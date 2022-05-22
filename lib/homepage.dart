import 'dart:convert';
import 'package:flutter_tutorial/settingpage.dart';
import 'package:flutter_tutorial/settingpagecomponents/editprofile_page.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial/model/user_model.dart';
import 'package:flutter_tutorial/settingpagecomponents/verfication_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

final List<String> imgList = [];

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
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {
        CircularProgressIndicator();
      });
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
              bottomRight: const Radius.elliptical(350, 40),
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
                  radius: 70,
                  child: CircleAvatar(
                    radius: 65,
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
                          decoration: TextDecoration.none,
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
                  height: 24,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "Phone Number : ",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        )),
                    TextSpan(
                      text: "${loggedInUser.phoneNumber}",
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.blueAccent,
                          fontSize: 17,
                          fontWeight: FontWeight.w700),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfile()));
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

Future _getData() async {
  var uploadUrl =
      "https://firebasestorage.googleapis.com/v0/b/muvmee-flutter.appspot.com/o/plate7.jpeg?alt=media&token=fc31eed9-4f62-408e-badd-2e9f3a1949d5";
  const url = "https://muvmeevision.herokuapp.com/apitest";
  final http.Response response = await http.post(
    Uri.parse("https://muvmeevision.herokuapp.com/apitest"),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      "imgurl": uploadUrl,
    }),
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    print("Get response");
    print(response);
    print(response.body);
  } else {
    throw Exception('Failed to create album.');
  }
}
