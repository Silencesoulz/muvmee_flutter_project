import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  String? licenseplate;
  String? displayIMG;
  String? phoneNumber;
  String? licenseRequest;

  UserModel({
    this.uid,
    this.email,
    this.firstName,
    this.lastName,
    this.licenseplate,
    this.displayIMG,
    this.phoneNumber,
    this.licenseRequest,
  });

  // retrieve data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      licenseplate: map['licenseplate'],
      displayIMG: map['displayIMG'],
      phoneNumber: map['phoneNumber'],
      licenseRequest: map['licenseRequest'],
    );
  }

  // sending data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'licenseplate': licenseplate,
      'displayIMG': displayIMG,
      'licenseRequest': licenseRequest,
    };
  }
}
