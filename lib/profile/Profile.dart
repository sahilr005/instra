import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram/Home/Story.dart';
import 'package:instagram/Posting/PostingPage.dart';
import 'package:instagram/main.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void getdata() {
    setState(() {});
    if (userinifomain.email != null) {
      FirebaseFirestore.instance
          .collection('User')
          .doc(userinifomain.email.toString())
          .get()
          .then(
            (value) => {
              postno = value.data()['postno'],
              print('Data get user infoooo..........')
            },
          );
    }
  }

  @override
  void initState() {
    setState(() {
      getdata();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/logo.jpg'))),
                ),
                Divider(),
                ListTile(
                  onTap: () {},
                  trailing: Icon(Icons.local_activity),
                  title: Text("Activite"),
                ),
                ListTile(
                  onTap: () {},
                  trailing: Icon(Icons.store_mall_directory),
                  title: Text("Story's"),
                ),
                ListTile(
                  onTap: () {},
                  trailing: Icon(Icons.settings),
                  title: Text("Setting"),
                ),
              ],
            ),
            ListTile(
              trailing: Icon(Icons.create),
              title: Text('Created By ....'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          userinifomain.name == null ? "name" : userinifomain.name,
          style: GoogleFonts.adamina(color: Colors.black, fontSize: 20),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              SizedBox(
                height: 14,
              ),
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * .109,
                  width: MediaQuery.of(context).size.width * .23,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: Colors.black,
                    image: DecorationImage(
                      image: NetworkImage(
                        userinifomain.photo == null
                            ? "https://cdn5.vectorstock.com/i/1000x1000/44/39/avatar-icon-male-person-symbol-circle-user-vector-20924439.jpg"
                            : userinifomain.photo,
                      ),
                      //
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                    userinifomain.name == null ? "name" : userinifomain.name,
                    style: GoogleFonts.rokkitt(fontSize: 20)),
              ),
              Center(
                child: Text('Bio', style: GoogleFonts.rokkitt(fontSize: 18)),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(4)),
                  width: MediaQuery.of(context).size.width * .35,
                  height: 28,
                  child: Center(
                      child: Text(
                    'Edit Profile',
                    style: GoogleFonts.rokkitt(fontSize: 17),
                  )),
                ),
              ),
              SizedBox(height: 8),
              Divider(),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(" Post's "),
                    Divider(),
                    IconButton(
                        icon: Icon(Icons.person_outline), onPressed: () {}),
                  ],
                ),
              ),
              Divider(),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height * .5,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Myposts')
                  .doc(userinifomain.email)
                  .collection('Mypost')
                  .orderBy("time", descending: true)
                  .snapshots(),
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

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * .51,
                        width: MediaQuery.of(context).size.width * .97,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              snap.data()['postimg'],
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
