import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram/Database/firedata.dart';
import 'package:instagram/Home/Home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instagram/homemain.dart';
import 'package:instagram/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage1 extends StatefulWidget {
  @override
  _LoginPage1State createState() => _LoginPage1State();
}

class _LoginPage1State extends State<LoginPage1> {
  @override
  void initState() {
    userinifomain = UserInfo1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/logo.jpg',
            width: MediaQuery.of(context).size.width * .3,
          ),
          Center(
            child: Text(
              'Instagram',
              style: GoogleFonts.lora(color: Colors.black, fontSize: 30),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () => signInWithGoogle(context: context),
            child: Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .06,
              child: Center(
                child: Text(
                  "Log in",
                  style: GoogleFonts.abel(color: Colors.white, fontSize: 19),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 17,
          ),
          Text(
            'Switch accounts',
            style: GoogleFonts.adamina(color: Colors.blue, fontSize: 15),
          ),
        ],
      ),
    );
  }
}

Future<UserCredential> signInWithGoogle({context}) async {
  FirebaseAuth.instance.authStateChanges().listen((User user) async {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      print('User is signed in!');
      adduser(
        name: user.displayName,
        phoneno: user.phoneNumber == null ? "no number" : user.phoneNumber,
        useremail: user.email,
        userphoto: user.photoURL,
        useruid: user.uid,
      );
      print('@');
      prefs.setBool('seen', true);

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (a) => MainPage(),
      ));
    }
  });

  final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  final GoogleAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
