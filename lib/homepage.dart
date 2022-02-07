import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial/model/user_model.dart';
import 'package:flutter_tutorial/settingpagecomponents/verfication_page.dart';
import 'package:path/path.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.home, size: 35),
      Icon(Icons.document_scanner, size: 35),
      Icon(Icons.settings, size: 35),
    ];
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 20),
        decoration: new BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: new BorderRadius.only(
              bottomRight: const Radius.elliptical(750, 1300),
            )),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(
              top: 80,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  " Welcome \u{1F44B} , ${loggedInUser.firstName} ",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 34,
                ),
                CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  radius: 57,
                  child: CircleAvatar(
                    radius: 53,
                    backgroundImage:
                        NetworkImage(loggedInUser.displayIMG.toString()),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "Name: ",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        )),
                    TextSpan(
                        text: "${loggedInUser.firstName}",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.w600)),
                  ]),
                ),
                SizedBox(
                  height: 22,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "License plate : ",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        )),
                    TextSpan(
                      text: "${loggedInUser.licenseplate}",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blueAccent,
                          fontSize: 17,
                          fontWeight: FontWeight.w700),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VerificationPage()));
                        },
                    ),
                  ]),
                ),
                SizedBox(
                  height: 100,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
