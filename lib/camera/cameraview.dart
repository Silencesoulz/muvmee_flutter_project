import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial/camera/scanresult.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class CameraViewPage extends StatefulWidget {
  CameraViewPage({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  State<CameraViewPage> createState() => _CameraViewPageState();
}

class _CameraViewPageState extends State<CameraViewPage> {
  late String urlpic;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 150,
              child: Image.file(
                File(widget.path),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xFF0D47A1),
                                Color(0xFF1976D2),
                                Color(0xFF42A5F5),
                              ],
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          alignment: Alignment.bottomCenter,
                          padding: const EdgeInsets.all(16.0),
                          primary: Colors.white,
                          textStyle: const TextStyle(fontSize: 18),
                        ),
                        onPressed: () {},
                        child: const Text('Scan License plate'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future uploadPic(BuildContext context) async {
    //fetch user email to set person path
    final _auth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    //convert Xfile to file
    File file = File(widget.path);
    String fileName = basename(widget.path);
    //generate random name for image
    Random random = Random();
    int i = random.nextInt(10000);
    //upload to firebase
    Reference reference =
        FirebaseStorage.instance.ref().child('CaptureImg/' + 'images$i.jpg');
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    //get downloadUrl
    var uploadUrl = await (await uploadTask).ref.getDownloadURL();
    print("Snapshot Uploaded");
    print(uploadUrl);
    print("send POST");
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
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => ScanPage(uploadUrl)));
      print("Get response");
      print(response);
      print(response.body);
    } else {
      throw Exception('Failed to create album.');
    }

    Future _getData() async {
      const url = "https://muvmeevision.herokuapp.com/apitest";
      try {
        final res = await http.get(Uri.parse(url));
        List<int> result = [];
        if (response.statusCode == 200) {
          final resBody = jsonDecode(res.body);
          print(resBody);
        } else {
          throw Exception('Failed to create album.');
        }
      } catch (e) {
        print("Error : $e");
      }
      // send url to model
      // final http.Response response = await http.post();
    }
  }
}

// class Album {
//   String? numberplate;
//   String? province;

//   Album({required this.numberplate, required this.province});

//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//       numberplate: json['numberplate'],
//       province: json['province'],
//     );
//   }
// }