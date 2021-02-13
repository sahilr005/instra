import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram/cate/Messges/page1.dart';
import 'package:instagram/cate/Secoundpage/All.dart';

import '../../main.dart';

class Screen1 extends StatefulWidget {
  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 1.0,
            actions: [],
            bottom: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height * .07),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 150),
                        child: Text(
                          'Messages',
                          style: GoogleFonts.actor(
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 13),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(userinifomain.photo),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 14),
                  TabBar(
                    indicatorColor: Colors.yellow[800],
                    indicatorWeight: 3.4,
                    tabs: [
                      Tab(
                        child: Text(
                          'Messages',
                          style: GoogleFonts.aBeeZee(
                              fontSize: 20,
                              fontWeight: FontWeight.w100,
                              color: Colors.white70),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Friends',
                          style: GoogleFonts.aBeeZee(
                              fontSize: 20,
                              fontWeight: FontWeight.w100,
                              color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              Messagespage(),
              AllFriends(),
            ],
          ),
        ),
      ),
    );
  }
}
