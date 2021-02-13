import 'package:flutter/material.dart';
import 'package:instagram/Database/postget.dart';
import 'package:instagram/Favrite/favri.dart';
import 'package:instagram/Home/Home.dart';
import 'package:instagram/New/Alluser.dart';
import 'package:instagram/Posting/PostingPage.dart';
import 'package:instagram/profile/Profile.dart';
import 'package:instagram/searchPage/Search.dart';

import 'Database/firedata.dart';
import 'main.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _currenIndex = 0;
  final tabs = [
    HomePage1(),
    Searchpage(),
    // All(),
    Posting(),
    Favritep(),
    ProfilePage(),
  ];

  @override
  void initState() {
    userinifomain = UserInfo1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey.shade400,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        currentIndex: _currenIndex,
        onTap: (index) {
          setState(() {
            _currenIndex = index;
          });
        },
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "find"),
          BottomNavigationBarItem(icon: Icon(Icons.person_add), label: "find"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: "Favoutie"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: "Account"),
        ],
      ),
      body: tabs[_currenIndex],
    );
  }
}
