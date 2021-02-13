import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Login/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Database/firedata.dart';
import 'package:path_provider/path_provider.dart';

import 'Database/postget.dart';
import 'homemain.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

var box;

UserInfo1 userinifomain;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instsgram',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splesh(),
    );
  }
}

class Splesh extends StatefulWidget {
  @override
  _SpleshState createState() => _SpleshState();
}

class _SpleshState extends State<Splesh> {
  SharedPreferences prefs;
  SharedPreferences _preferences;
  bool _seen;
  Future checkFirstSeen() async {
    prefs = await SharedPreferences.getInstance();
    _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (a) => MainPage()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage1()));
    }
  }

  Future openBOx() async {
    setState(() {});
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('SchatS');
    return;
  }

  @override
  void initState() {
    super.initState();
    openBOx();
    Postget();

    Timer(
      Duration(seconds: 3),
      () => checkFirstSeen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Image.asset('assets/logo.jpg'),
    );
  }
}
