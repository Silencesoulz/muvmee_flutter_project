import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter_tutorial/login.dart';
import 'package:flutter_tutorial/settingpagecomponents/editprofile_page.dart';
import 'package:flutter_tutorial/settingpagecomponents/icon_widget.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SimpleSettingsTile(
        title: 'Edit Profile',
        subtitle: 'Name, License plate number',
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => EditProfile()));
        },
        leading: IconWidget(icon: Icons.edit, color: Colors.green),
      );

  Widget buildAccountInfo(BuildContext context) => SimpleSettingsTile(
        title: 'Account Info',
        subtitle: '',
        leading: IconWidget(icon: Icons.info, color: Colors.blue),
        onTap: () {},
      );

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
