import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram/Database/firedata.dart';
import 'package:instagram/Home/Story.dart';
import 'package:instagram/Home/post.dart';

import '../main.dart';

class Favritep extends StatefulWidget {
  @override
  _FavritepState createState() => _FavritepState();
}

class _FavritepState extends State<Favritep> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          title: Text(
            "All Friends",
            style: GoogleFonts.caudex(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 1.0,
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('User').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot snap = snapshot.data.docs[index];
                  return ListTile(
                    title: Text(snap.data()['Name']),
                    subtitle: Text(snap.data()['email']),
                    leading: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(snap.data()['photo'])),
                  );
                });
          },
        ));
  }
}
