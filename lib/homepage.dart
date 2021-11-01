import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial/camerapage.dart';
import 'package:flutter_tutorial/login.dart';
import 'package:flutter_tutorial/model/user_model.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_tutorial/settingpage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  int index = 2;

  final screens = [
    HomeScreen(),
    CameraPage(),
    SettingPage(),
  ];
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
    return Container(
      color: Colors.lightBlue,
      child: SafeArea(
        top: false,
        child: ClipRect(
          child: Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: Theme(
              data: Theme.of(context)
                  .copyWith(iconTheme: IconThemeData(color: Colors.grey[50])),
              child: CurvedNavigationBar(
                animationCurve: Curves.fastLinearToSlowEaseIn,
                animationDuration: Duration(milliseconds: 1500),
                color: Colors.lightBlue,
                backgroundColor: Colors.transparent,
                buttonBackgroundColor: Colors.lightBlue,
                height: 45,
                index: index,
                items: items,
                onTap: (index) => setState(() => this.index = index),
              ),
            ),
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 180,
                      child: Image.asset("assets/images/splash.png",
                          fit: BoxFit.contain),
                    ),
                    Text(
                      "MuvMeeยินดีต้อนรับ คุณ${loggedInUser.firstName}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(" ${loggedInUser.firstName} ${loggedInUser.lastName}",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        )),
                    Text("หมายเลขทะเบียน: ${loggedInUser.licenseplate}",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        )),
                    SizedBox(
                      height: 100,
                    ),
                    ActionChip(
                        label: Text("Logout"),
                        onPressed: () {
                          logout(context);
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Bottom Navbar",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
