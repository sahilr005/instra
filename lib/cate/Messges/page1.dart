import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram/cate/Messges/Page2.dart';

import '../../main.dart';

class Messagespage extends StatefulWidget {
  @override
  _MessagespageState createState() => _MessagespageState();
}

class _MessagespageState extends State<Messagespage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('mainscreen')
                .doc(userinifomain.uid)
                .collection(userinifomain.name)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return CircularProgressIndicator();
              }

              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, index) {
                  DocumentSnapshot snap = snapshot.data.docs[index];
                  // var date = snap.data()['time'].toString();
                  var date = DateTime.now().toString();

                  var dateParse = DateTime.parse(date);

                  var timedate =
                      "${dateParse.day}-${dateParse.month}-${dateParse.year}";
                  if (box == null) {
                    CircularProgressIndicator();
                  }
                  if (box.toMap().containsValue(snap.data()['idTo'])) {
                    print('@Uuu NOt Addded');
                  } else {
                    print('@Uuu addded');
                    box.add(snap.data()['idTo']);
                  }
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (a) => ChatPage2(
                            image: snap.data()['photo'],
                            lasttime: "2 min",
                            name: snap.data()['Name'],
                            userid: snap.data()['recid'],
                          ),
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage(
                        snap.data()['photo'],
                      ),
                    ),
                    title: Text(
                      snap.data()['recName'],
                      style: GoogleFonts.abel(
                          color: Colors.white70,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      snap.data()['about'],
                      style:
                          GoogleFonts.abel(fontSize: 12, color: Colors.white70),
                    ),
                    trailing: Column(
                      children: [
                        Text(
                          timedate.toString(),
                          style: GoogleFonts.abel(
                              color: Colors.grey, fontSize: 12),
                        ),
                        // CircleAvatar(
                        //   backgroundColor: Colors.yellow[900],
                        //   radius: 10,
                        //   child: Text(
                        //     '2',
                        //     style: TextStyle(fontSize: 10, color: Colors.white),
                        //   ),  
                        // )
                      ],
                    ),
                  );
                },
              );
            })
      ],
    );
  }
}
