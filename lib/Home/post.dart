import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram/FullPhoto/Fullimage.dart';
import 'package:instagram/main.dart';
import 'package:like_button/like_button.dart';
import 'package:instagram/Database/firedata.dart';
import 'package:share/share.dart';

class 
PostView extends StatefulWidget {
  final postimg;
  final username;
  final userimg;
  final posttage;
  final int likes;
  final uid;
  const PostView(
      {Key key,
      this.postimg,
      this.username,
      this.userimg,
      this.posttage,
      this.likes,
      this.uid})
      : super(key: key);
  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  bool val = false;
  UserInfo1 userInfo2;
  @override
  void initState() {
    setState(() {});
    userInfo2 = UserInfo1();
    super.initState();
  }

  CollectionReference users = FirebaseFirestore.instance.collection('posts');

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      elevation: 3,
      child: Column(
        children: [
          Column(
            children: [
              ListTile(
                title: Text(
                  widget.username == null ? "Friend" : widget.username,
                  style: GoogleFonts.aladin(fontSize: 16),
                ),
                subtitle: Text(
                  widget.posttage == null ? "GooD" : widget.posttage,
                  style: GoogleFonts.aladin(fontSize: 16),
                ),
                leading: InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (a) => FullImage(
                            img: widget.userimg,
                          ))),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      widget.userimg == null
                          ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMXp7sEViTSmJ29IEas0dGTz3RrBRUD8opCg&usqp=CAU"
                          : widget.userimg.toString(),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                trailing: InkWell(
                    onTap: () {
                      Share.share(widget.postimg, subject: 'post Link');
                    },
                    child: Icon(Icons.share_rounded)),
              ),
              InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (a) => FullImage(
                          img: widget.postimg,
                        ))),
                child: Container(
                    height: MediaQuery.of(context).size.height * .37,
                    child: Image.network(
                      widget.postimg == null
                          ? "https://images.unsplash.com/photo-1508674861872-a51e06c50c9b?ixid=MXwxMjA3fDB8MHx0b3BpYy1mZWVkfDQwfHRvd0paRnNrcEdnfHxlbnwwfHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"
                          : widget.postimg,
                      fit: BoxFit.fill,
                    )),
              ),
              Divider(
                endIndent: 15,
                indent: 15,
              ),
              Row(
                children: [
                  IconButton(
                    icon: val
                        ? Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : Icon(
                            Icons.favorite,
                            color: Colors.grey,
                          ),
                    onPressed: () {
                      setState(() {
                        val = !val;
                        if (val) {
                          users
                              .doc(widget.uid)
                              .update({'likes': widget.likes + 1})
                              .then(
                                (valuue) => setState(() {
                                  print('2');
                                }),
                              )
                              .catchError((error) =>
                                  print("Failed to update user: $error"));
                        }
                        if (!val) {
                          users
                              .doc(widget.uid)
                              .update({'likes': widget.likes - 1}).then(
                            (valuue) => setState(() {
                              print('2');
                            }),
                          );
                        }
                      });
                    },
                  ),
                  Text(
                    widget.likes.toString() + " Like's ",
                    style:
                        GoogleFonts.acme(fontSize: 15, color: Colors.grey[700]),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
