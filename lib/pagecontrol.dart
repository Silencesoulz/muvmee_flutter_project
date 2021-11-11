import 'package:flutter/material.dart';
import 'package:flutter_tutorial/camerascreen.dart';
import 'package:flutter_tutorial/homepage.dart';
import 'package:flutter_tutorial/settingpage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class PageControl extends StatefulWidget {
  const PageControl({Key? key}) : super(key: key);

  @override
  _PageControl createState() => _PageControl();
}

class _PageControl extends State<PageControl> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 0;

  final screens = [
    HomeScreen(),
    CameraScreen(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.home, size: 35),
      Icon(Icons.camera, size: 35),
      Icon(Icons.settings, size: 35),
    ];
    return Container(
      color: Colors.blue.shade400,
      child: SafeArea(
        top: false,
        child: ClipRect(
          child: Scaffold(
            extendBody: true,
            body: screens[index],
            backgroundColor: Colors.white,
            bottomNavigationBar: Theme(
              data: Theme.of(context)
                  .copyWith(iconTheme: IconThemeData(color: Colors.grey[50])),
              child: CurvedNavigationBar(
                key: navigationKey,
                animationCurve: Curves.fastLinearToSlowEaseIn,
                animationDuration: Duration(milliseconds: 1200),
                color: Colors.lightBlue.shade500,
                backgroundColor: Colors.transparent,
                buttonBackgroundColor: Colors.blue.shade500,
                height: 60,
                index: index,
                items: items,
                onTap: (index) => setState(() => this.index = index),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
