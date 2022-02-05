import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tutorial/google_page_control.dart';
import 'package:flutter_tutorial/google_sign_in.dart';
import 'package:flutter_tutorial/model/user_model.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter_tutorial/settingpagecomponents/account_page.dart';
import 'package:flutter_tutorial/settingpagecomponents/header_page.dart';
import 'package:flutter_tutorial/settingpagecomponents/icon_widget.dart';
import 'package:flutter_tutorial/settingpagecomponents/verfication_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  // For get user details.
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(24),
            children: [
              SettingsGroup(
                title: 'General',
                children: <Widget>[
                  HeaderPage(),
                  AccountPage(),
                  buildLicenseVerification(),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              SettingsGroup(
                title: 'Feedback',
                children: <Widget>[
                  const SizedBox(height: 16),
                  buildReportBug(context),
                  buildSendFeedback(context),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: buildLogout(),
                  ),
                ],
              ),
              const SizedBox(
                height: 200,
              ),
              Text(
                "MuvMee Official ",
                textAlign: TextAlign.right,
              )
            ],
          ),
        ),
      );

  Widget buildLicenseVerification() => SimpleSettingsTile(
        title: 'Verification',
        subtitle: 'License plate No.',
        leading: IconWidget(
            icon: Icons.verified_outlined, color: Colors.yellow.shade700),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => VerificationPage()));
        },
      );

  Widget buildLogout() => SimpleSettingsTile(
        title: 'Log Out',
        subtitle: '',
        leading:
            IconWidget(icon: Icons.logout_rounded, color: Colors.pink.shade400),
        onTap: () {
          logout(context);
          final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
          provider.logout();
        },
      );
}

Widget buildReportBug(BuildContext context) => SimpleSettingsTile(
      title: 'Report a Problem',
      subtitle: '',
      leading: IconWidget(icon: Icons.warning, color: Colors.yellow.shade800),
      onTap: () {
        Fluttertoast.showToast(msg: "Report Successful");
      },
    );

Widget buildSendFeedback(BuildContext context) => SimpleSettingsTile(
      title: 'Send Feedback',
      subtitle: '',
      leading: IconWidget(icon: Icons.feedback_sharp, color: Colors.lightBlue),
      onTap: () {
        Fluttertoast.showToast(msg: "Send Feedback");
      },
    );

Future<void> logout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => StatePageControl()));
}
