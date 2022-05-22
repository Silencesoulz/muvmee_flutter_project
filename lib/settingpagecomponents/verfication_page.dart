import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial/model/user_model.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  //user model
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

  final licenseRequestEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final licensRequestField = TextFormField(
      readOnly: true,
      autofocus: false,
      controller: licenseRequestEditingController,
      keyboardType: TextInputType.text,
      validator: (null),
      onSaved: (value) {
        licenseRequestEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon:
            Icon(Icons.format_list_numbered_sharp, color: Colors.blue.shade700),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "License Plate Number (e.g. 1กก 1111)",
        hintStyle: TextStyle(color: Colors.blue.shade700),
        hintMaxLines: 2,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Verification"),
        backgroundColor: Colors.blue.shade400,
      ),
    );
  }
}
