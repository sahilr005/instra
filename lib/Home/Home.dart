import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/Database/firedata.dart';
import 'package:instagram/Home/Story.dart';
import 'package:instagram/Home/post.dart';
import 'package:instagram/cate/firestpage/Scerren1.dart';

import '../main.dart';

class HomePage1 extends StatefulWidget {
  @override
  _HomePage1State createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  var fireimg = null;
  int timeInMillis = 1586348737122;
  var _image = null;

  Future<void> getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
      print('_____----------------------------');
      print(image.toString());
      if (_image != null) {
        Timestamp tm = Timestamp.now();

        FirebaseStorage fs = FirebaseStorage.instance;
        Reference rootref = fs.ref();
        Reference picther = rootref.child(tm.microsecondsSinceEpoch.toString());
        picther.putFile(_image).then((value) async {
          String link = await value.ref.getDownloadURL();
          setState(() {
            fireimg = link;
            _image = null;

            if (userinifomain.name != null) {
              PostSend(
                  postimg: link.toString(),
                  like: "1",
                  posttag: "Camera pik",
                  uid: userinifomain.uid,
                  userimg: userinifomain.photo,
                  username: userinifomain.name);
            }
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.9,
        leading: InkWell(
          onTap: () {
            getImage();
          },
          child: Icon(
            Icons.camera_alt_outlined,
            color: Colors.blueGrey,
            size: 31,
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.send_rounded,
                color: Colors.black,
              ),
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (sa) => Screen1()))),
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Instagram',
          style: GoogleFonts.lora(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .doc()
                  .collection('post')
                  .orderBy("time", descending: true)
                  .snapshots(),
              builder: (ctx, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return new ListView(
                  children: snapshot.data.docs.map(
                    (DocumentSnapshot document) {
                      var one = int.parse(document.data()['likes'].toString());

                      return PostView(
                        uid: document.data()['uid'],
                        likes: one,
                        username: document.data()['username'],
                        posttage: document.data()['posttage'],
                        postimg: document.data()['postimg'],
                        userimg: document.data()['userimg'],
                      );
                    },
                  ).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
