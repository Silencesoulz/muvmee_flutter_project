import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.blue),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 180,
                      child: Image.asset(
                        "assets/images/splash.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    //firstNameField,
                    SizedBox(
                      height: 24,
                    ),
                    //lastNameField,
                    SizedBox(
                      height: 24,
                    ),
                    //licensePlateField,
                    SizedBox(
                      height: 24,
                    ),
                    //emailField,
                    SizedBox(
                      height: 24,
                    ),
                    //passwordField,
                    SizedBox(
                      height: 24,
                    ),
                    //confirmPasswordField,
                    SizedBox(
                      height: 40,
                    ),
                    //signUpButton,
                    SizedBox(
                      height: 19,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
