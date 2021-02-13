import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:instagram/Database/firedata.dart';
import 'package:instagram/cate/Messges/Page2.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../../main.dart';

class AllFriends extends StatefulWidget {
  @override
  _AllFriendsState createState() => _AllFriendsState();
}

class _AllFriendsState extends State<AllFriends> {
  @override
  void initState() {
    openBOx();
    super.initState();
  }

  Future openBOx() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('ChatMe');
    return;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: StreamBuilder(
      stream: FirebaseFirestore.instance.collection('User').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        if (snapshot.data.docs == null) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: snapshot.data.docs.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            DocumentSnapshot snap = snapshot.data.docs[index];
            if (!snap.exists) CircularProgressIndicator();

            if (snap.data()['Name'] == null) {
              CircularProgressIndicator();
            }
            return ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (a) => ChatPage2(
                      image: snap.data()['photo'],
                      lasttime: "2 min",
                      name: snap.data()['Name'],
                      userid: snap.data()['uid'],
                    ),
                  ),
                );
                print(box.toMap());

                if (box.toMap().containsValue(snap.id)) {
                  print('@Uuu not  addded');
                } else {
                  Daata().setData(snap: snap, reciverid: snap.id.toString());
                  print('@Uuu addded');
                  box.add(snap.id);
                }
              },
              trailing: Text(snap.data()['time'].toString()),
              title: Text(
                snap.data()['Name'],
                style: GoogleFonts.abhayaLibre(color: Colors.grey[350]),
              ),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(snap.data()['photo']),
              ),
            );
          },
        );
      },
    ));
  }
}
