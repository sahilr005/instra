import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Postget extends StatefulWidget {
  @override
  _PostgetState createState() => _PostgetState();
}

List post = List();

class _PostgetState extends State<Postget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('post').snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.hasError) {
          print('erros');
        }
        if (!snapshot.hasData) {
          print('No Dataa.....');
        }
        if (snapshot.hasData) {
          return ListView(children: getExpenseItems(snapshot));
        }
      },
    );
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.docs.map((doc) {
      post.add(doc['img']);
      print(post);
      return Text('data');
    }).toList();
  }
}
