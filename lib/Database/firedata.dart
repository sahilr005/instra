import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

void adduser({useremail, name, userphoto, phoneno, useruid}) async {
  await firestore.collection('User').doc(useremail).set({
    "Name": name,
    "email": useremail,
    "photo": userphoto,
    "phoneNo": phoneno,
    "uid": useruid,
    "postno": 1,
    "chattingWith": null,
    'time': DateTime.now(),
  });
}

class UserInfo1 {
  var name;
  var photo;
  var email;
  var uid;
  var postno;

  UserInfo1() {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      name = user.displayName;
      photo = user.photoURL;
      email = user.email;
      uid = user.uid;
    }).onDone(() {
      FirebaseFirestore.instance
          .collection('User')
          .doc(email.toString())
          .get()
          .then(
            (value) => {
              postno = value.data()['postno'],
              print('Data get user infoooo..........')
            },
          );
    });
  }
}

void messageSend({message, peerid, mtime, uid, recuid, docref}) async {
  var docref = FirebaseFirestore.instance
      .collection('message')
      .doc(peerid)
      .collection(peerid)
      .doc(DateTime.now().millisecondsSinceEpoch.toString());

  try {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(docref, {
        "idFrom": uid,
        "idTo": recuid,
        "read": "No",
        "peerid": peerid,
        "timestemp": mtime,
        "Message": message
        // 'playerID': token
      });
    });
  } on Exception catch (e) {
    print('send data erros');
  }
}

class Daata {
  SharedPreferences preferences;

  void setData({snap, reciverid}) async {
    preferences = await SharedPreferences.getInstance();

    var docref = FirebaseFirestore.instance
        .collection('mainscreen')
        .doc(userinifomain.uid.toString())
        .collection(userinifomain.name.toString())
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(docref, {
        "idFrom": userinifomain.name.toString(),
        "idTo": snap.id.toString(),
        "recid": snap.data()['uid'],
        "recName": snap.data()['Name'].toString(),
        "about": snap.data()['About'] == null
            ? "Friends"
            : snap.data()['About'].toString(),
        "photo": snap.data()['photo'].toString(),
        "read": "No",
        'playerID': snap.data()['playerID'].toString(),
        "timestemp": DateTime.now().millisecondsSinceEpoch.toString(),
      });
    });

    var recobj = FirebaseFirestore.instance
        .collection('mainscreen')
        .doc(snap.id.toString())
        .collection(snap.data()['Name'].toString())
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(recobj, {
        "idTo": userinifomain.uid.toString(),
        "recName": userinifomain.name.toString(),
        "about": 'set About..',
        "photo": userinifomain.photo,
        'playerID': userinifomain.uid,
        "timestemp": DateTime.now().millisecondsSinceEpoch.toString(),
      });
    });
  }
}

class PostinfoGet {
  var uid;
  var postpturl;
  var userimg;
  var like;
  var username;
  var posttag;

  PostinfoGet() {
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                print('**');
                print(doc["img"]);
                postpturl = doc['postimg'];
                uid = doc['uid'];
                userimg = doc['userimg'];
                like = doc['likes'];
                username = doc['username'];
                posttag = doc['posttage'];
              }),
            });
  }
}

class PostSend {
  final uid;
  final postimg;
  final userimg;
  final like;
  final username;
  final posttag;

  PostSend(
      {this.uid,
      this.postimg,
      this.userimg,
      this.like,
      this.username,
      this.posttag}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc()
        .collection('post')
        .add({
      "uid": uid.toString(),
      "postimg": postimg.toString(),
      "userimg": userimg.toString(),
      "likes": like.toString(),
      "username": username.toString(),
      "posttage": posttag.toString(),
      "time": DateTime.now(),
    }).whenComplete(() => {
              FirebaseFirestore.instance
                  .collection('Myposts')
                  .doc(userinifomain.email)
                  .collection("Mypost")
                  .add({
                "uid": uid.toString(),
                "postimg": postimg.toString(),
                "userimg": userimg.toString(),
                "likes": like.toString(),
                "username": username.toString(),
                "posttage": posttag.toString(),
                'time': DateTime.now(),
              }),
            });
  }
}
