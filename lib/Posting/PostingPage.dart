import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/Database/firedata.dart';
import 'package:instagram/Database/postget.dart';
import 'package:instagram/main.dart';

class Posting extends StatefulWidget {
  @override
  _PostingState createState() => _PostingState();
}

var postno;

// TODO postno make perminate use hive......................
class _PostingState extends State<Posting> {
  var _image = null;
  var fireimg = null;
  int timeInMillis = 1586348737122;
  var emmmil;
  String downloadURL;

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Posting Image',
          style: GoogleFonts.lora(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1.0,
        actions: [
          _image == null
              ? Text('')
              : IconButton(
                  icon: Icon(Icons.done, color: Colors.black),
                  onPressed: () async {
                    Timestamp tm = Timestamp.now();
                    emmmil = userinifomain.email.toString();
                    if (_image != null) {
                      FirebaseStorage fs = FirebaseStorage.instance;
                      Reference rootref = fs.ref();
                      Reference picther =
                          rootref.child(tm.microsecondsSinceEpoch.toString());
                      picther.putFile(_image).then((value) async {
                        String link = await value.ref.getDownloadURL();
                        setState(() {
                          fireimg = link;
                          _image = null;

                          if (userinifomain.name != null) {
                            PostSend(
                                postimg: link.toString(),
                                like: "1",
                                posttag: "Redy",
                                uid: userinifomain.uid,
                                userimg: userinifomain.photo,
                                username: userinifomain.name);
                            
                            // FirebaseFirestore.instance
                            //     .collection('User')
                            //     .doc(userinifomain.email)
                            //     .update({"postno": ++postno});
                          }
                          print('done......... $postno');
                        });
                      });
                    }
                  },
                ),
        ],
      ),
      body: Center(
        child: _image == null ? Text('No image selected.') : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => getImage(),
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  Future<void> getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      print('_____----------------------------');
      print(image.toString());
      print('_____----------------------------');
    });
  }
}
