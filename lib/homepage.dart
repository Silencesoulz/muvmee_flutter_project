import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
import 'model/user_model.dart';

final List<String> imgList = [];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

int _messageCount = 0;

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  String? _token;

  String constructFCMPayload(String? token) {
    _messageCount++;
    return jsonEncode({
      'token': token,
      'data': {
        'via': 'FlutterFire Cloud Messaging!!!',
        'count': _messageCount.toString(),
      },
      'notification': {
        'title': 'Hello FlutterFire!',
        'body': 'This notification (#$_messageCount) was created via FCM!',
      },
    });
  }

  @override
  void initState() {
    super.initState();
    firebaseMessaging.getToken().then((token) {
      _token = token;
      print('token');
      print(_token);
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message received");
      print(event.notification!.body);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification!.body);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Notification"),
              content: Text(event.notification!.body!),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });

    Future<void> _messageHandler(RemoteMessage message) async {
      print('background message ${message.notification!.body}');
    }

    void main() async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      FirebaseMessaging.onBackgroundMessage(_messageHandler);
      runApp(HomeScreen());
    }

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });

    Future<void> sendPushMessage() async {
      if (_token == null) {
        print('Unable to send FCM message, no token exists.');
        return;
      }

      try {
        await http.post(
          Uri.parse('https://api.rnfirebase.io/messaging/send'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: constructFCMPayload(_token),
        );
        print('FCM request for device sent!');
      } catch (e) {
        print(e);
      }
    }

    //Firebase database
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
                  height: 46,
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
                  height: 32,
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
                        text: "",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        )),
                    TextSpan(
                      text: "",
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
