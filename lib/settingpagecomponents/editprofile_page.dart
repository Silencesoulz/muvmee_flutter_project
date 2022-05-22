import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial/model/user_model.dart';
import 'package:flutter_tutorial/pagecontrol.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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

  //form
  final firstNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final licenseplateEditingController = new TextEditingController();
  final currentFirstNameController = new TextEditingController();
  final phoneNumberEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{1,}$');
        if (value!.isEmpty) {
          return ("Insert your update name");
        }
        if (!regex.hasMatch(value)) {
          return ("Invalid name");
        }
      },
      onSaved: (value) {
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.edit_attributes),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Type your name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final emailField = TextFormField(
      readOnly: true,
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (null),
      onSaved: (value) {
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.email,
          color: Colors.blue.shade700,
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "${loggedInUser.email}",
        hintStyle: TextStyle(
          color: Colors.blue.shade700,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final licensePlateField = TextFormField(
      readOnly: true,
      autofocus: false,
      controller: licenseplateEditingController,
      keyboardType: TextInputType.text,
      validator: (null),
      onSaved: (value) {
        licenseplateEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon:
            Icon(Icons.format_list_numbered_sharp, color: Colors.blue.shade700),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "${loggedInUser.licenseplate}",
        hintStyle: TextStyle(color: Colors.blue.shade700),
        hintMaxLines: 2,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final currentFirstName = TextFormField(
      readOnly: true,
      autofocus: false,
      controller: currentFirstNameController,
      keyboardType: TextInputType.text,
      validator: (null),
      // onSaved: (value) {
      //   licenseplateEditingController.text = value!;
      // },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon:
            Icon(Icons.account_circle_sharp, color: Colors.blue.shade700),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "${loggedInUser.firstName}",
        hintStyle: TextStyle(color: Colors.blue.shade700),
        hintMaxLines: 2,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final phoneNumberField = TextFormField(
      readOnly: false,
      autofocus: false,
      controller: phoneNumberEditingController,
      keyboardType: TextInputType.number,
      validator: (null),
      onSaved: (value) {
        phoneNumberEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.phone_android),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "${loggedInUser.phoneNumber}",
        hintMaxLines: 2,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final SaveButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue.shade500,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          {
            {
              postDetailsToFirestore();
            }
          }
        },
        child: Text(
          "Save",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Edit profile'),
        backgroundColor: Colors.blue.shade400,
        // elevation: 0,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back_ios_new, color: Colors.blue),
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.grey.shade50,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // RichText(
                      //   textAlign: TextAlign.center,
                      //   text: TextSpan(children: <TextSpan>[
                      //     TextSpan(
                      //         text: "",
                      //         style: TextStyle(
                      //           color: Colors.black87,
                      //           fontWeight: FontWeight.w700,
                      //           fontSize: 24,
                      //         )),
                      //   ]),
                      // ),
                      SizedBox(
                        height: 8,
                      ),
                      Stack(
                        children: [
                          Container(
                            child: CircleAvatar(
                              backgroundColor: Colors.blueGrey,
                              radius: 61,
                              child: CircleAvatar(
                                radius: 56,
                                backgroundImage: NetworkImage(
                                    loggedInUser.displayIMG.toString()),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 76,
                            left: 56,
                            child: RawMaterialButton(
                              elevation: 2,
                              fillColor: Colors.grey.shade200,
                              padding: EdgeInsets.all(8.0),
                              shape: CircleBorder(),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          title: Text(
                                            'Choose option',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black),
                                          ),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: [
                                                InkWell(
                                                  onTap: () {},
                                                  splashColor:
                                                      Colors.blueAccent,
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Icon(
                                                          Icons
                                                              .picture_in_picture,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                      Text(" Gallery",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 18,
                                                              color: Colors
                                                                  .black)),
                                                    ],
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {},
                                                  splashColor:
                                                      Colors.blueAccent,
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Icon(
                                                          Icons.link_rounded,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                      Text(" Link",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 18,
                                                              color: Colors
                                                                  .black)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ));
                                    });
                              },
                              child: Icon(Icons.add_a_photo),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 46,
                      ),
                      currentFirstName,
                      SizedBox(
                        height: 24,
                      ),
                      firstNameField,
                      SizedBox(
                        height: 24,
                      ),
                      emailField,
                      SizedBox(
                        height: 24,
                      ),
                      licensePlateField,
                      SizedBox(
                        height: 24,
                      ),
                      phoneNumberField,
                      SizedBox(
                        height: 36,
                      ),
                      SaveButton,
                      SizedBox(
                        height: 24,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void postDetailsToFirestore() async {
    // calling firestore
    // calling user model
    // sending the values
    if (_formKey.currentState!.validate()) {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      User? user = _auth.currentUser;
      UserModel userModel = UserModel();
      String DisplayPic = loggedInUser.displayIMG.toString();
      String LicensePlate = loggedInUser.licenseplate.toString();
      // writing all the values
      userModel.email = user!.email;
      userModel.uid = user.uid;
      userModel.firstName = firstNameEditingController.text;
      userModel.displayIMG = DisplayPic;
      userModel.licenseplate = LicensePlate;
      userModel.phoneNumber = phoneNumberEditingController.text;

      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .set(userModel.toMap());
      Fluttertoast.showToast(msg: "Your profile are updated!");
      Navigator.of(context).pop();
    }
  }
}
