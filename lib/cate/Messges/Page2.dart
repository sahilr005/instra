import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram/Database/firedata.dart';

import '../../main.dart';


class ChatPage2 extends StatefulWidget {
  final image;
  final name;
  final lasttime;
  final userid;

  const ChatPage2({Key key, this.image, this.name, this.lasttime, this.userid})
      : super(key: key);
  @override
  _ChatPage2State createState() => _ChatPage2State();
}

class _ChatPage2State extends State<ChatPage2> {
  ScrollController listScrollController = new ScrollController();

  TextEditingController messagecontroller = TextEditingController();
  var peerid;
  var curuid;
  var reciverid;
  var docref;
  @override
  void initState() {
    curuid = userinifomain.uid.toString();
    reciverid = widget.userid;
    readlocal();
    super.initState();
  }

  void readlocal() async {
    if (curuid.hashCode <= reciverid.hashCode) {
      peerid = '$curuid-$reciverid';
    } else {
      peerid = '$reciverid-$curuid';
    }
    print('$reciverid' + 'recvier id......   .... .. ... . . .');
    print('cur User Id ' + curuid);

    docref = FirebaseFirestore.instance
        .collection('message')
        .doc(peerid)
        .collection(peerid)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());
    // FirebaseFirestore.instance
    //     .collection('User')
    //     .doc(curuid)
    //     .update({'chattingWith': '$reciverid'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        brightness: Brightness.dark,
        centerTitle: false,
        backgroundColor: Colors.black54,
        elevation: 1.0,
        leadingWidth: 10.0,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: ListTile(
          title: Text(
            widget.name == null ? 'Sahil R' : widget.name,
            style: GoogleFonts.abhayaLibre(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          subtitle: Text(
            widget.lasttime == null
                ? "last Active 3 ago"
                : "last Active " + widget.lasttime,
            style: GoogleFonts.abhayaLibre(fontSize: 13, color: Colors.white),
          ),
          trailing:
              Icon(Icons.videocam_outlined, size: 30, color: Colors.white),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              widget.image == null
                  ? 'https://images.unsplash.com/photo-1491349174775-aaafddd81942?ixid=MXwxMjA3fDB8MHxzZWFyY2h8OHx8cGVyc29ufGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'
                  : widget.image,
            ),
          ),
        ),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 75),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white30, width: 2),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('message')
                            .doc(peerid)
                            .collection(peerid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            Center(child: CircularProgressIndicator());
                          }
                          return !snapshot.hasData
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ListView.builder(
                                  reverse: true,
                                  shrinkWrap: true,
                                  controller: listScrollController,
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot snap =
                                        snapshot.data.docs[index];
                                    return Container(
                                      padding: EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          top: 10,
                                          bottom: 10),
                                      child: Align(
                                        alignment:
                                            (snap.data()['idTo'] == curuid
                                                ? Alignment.topLeft
                                                : Alignment.topRight),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color:
                                                (snap.data()['idTo'] == curuid
                                                    ?
                                                    // ? dark
                                                    //     ? Colors.black
                                                    Colors.lightBlue[800]
                                                    :
                                                    //  dark
                                                    //     ? Colors.black45:
                                                    Colors.blueGrey),
                                          ),
                                          padding: EdgeInsets.all(16),
                                          child: InkWell(
                                              onTap: () {
                                                // Flushbar(
                                                //   flushbarPosition:
                                                //       FlushbarPosition.TOP,
                                                //   title: "Time",
                                                //   flushbarStyle:
                                                //       FlushbarStyle.FLOATING,
                                                //   duration: Duration(seconds: 2),
                                                //   message: snap
                                                //       .data()["timestemp"]
                                                //       .toString(),
                                                //   margin: EdgeInsets.all(28),
                                                //   borderRadius: 8,
                                                // )..show(context);
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                // mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    snap.data()["Message"],
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  snap.data()["read"] != null
                                                      ? snap.data()['idTo'] ==
                                                              curuid
                                                          ? Offstage()
                                                          // snap.data()['read'] == 'No'
                                                          //     ? Icon(Icons.ac_unit)
                                                          //     : Icon(Icons.check)
                                                          : snap.data()[
                                                                      'read'] ==
                                                                  'No'
                                                              ? Icon(
                                                                  Icons
                                                                      .done_all_rounded,
                                                                  color: Colors
                                                                          .blueGrey[
                                                                      900],

                                                                  // color: dark
                                                                  //     ? Colors.yellow
                                                                  //     : Colors.blue,
                                                                  size: 15,
                                                                )
                                                              : Icon(
                                                                  Icons
                                                                      .done_all,
                                                                  color: Colors
                                                                      .white,
                                                                  // color: dark
                                                                  //     ? Colors
                                                                  //         .pinkAccent
                                                                  //     : Colors.green,
                                                                  size: 18,
                                                                )
                                                      : Offstage(),

                                                  // Icon(Icons.check),
                                                  //................................
                                                  // snap.data()["read"] != null
                                                  //     ? Text(snap.data()["read"])
                                                  //     : Text("No Data"),
                                                ],
                                              )),
                                        ),
                                      ),
                                    );
                                  });
                        },
                      ),
                      //
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(color: Colors.white30, width: 2),
                    color: Colors.grey[900],
                  ),
                  padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  height: 60,
                  width: double.infinity,
                  // color: Colors.grey[800],
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextField(
                          controller: messagecontroller,
                          style: TextStyle(color: Colors.grey),
                          decoration: InputDecoration(
                              hintText: "Write message...",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          messageSend(
                              message: messagecontroller.text,
                              peerid: peerid,
                              recuid: reciverid,
                              mtime: DateTime.now(),
                              uid: curuid,
                              docref: docref);
                          messagecontroller.clear();
                        },
                        child: Icon(
                          Icons.send_outlined,
                          color: Colors.white,
                          size: 18,
                        ),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
