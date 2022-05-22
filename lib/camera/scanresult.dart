import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial/camera/cameraview.dart';
import 'package:path/path.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ScanPage extends StatefulWidget {
  final result;
  final phonenumber;
  // final _token;

  ScanPage(this.result, this.phonenumber);

  @override
  _ScanPageState createState() => _ScanPageState();
}

int _messageCount = 0;

class _ScanPageState extends State<ScanPage> {
  String constructFCMPayload(String? token) {
    _messageCount++;
    return jsonEncode({
      'token': token,
      'data': {
        'via': 'FlutterFire Cloud Messaging!!!',
        'count': _messageCount.toString(),
      },
      'notification': {
        'title': 'MuvMee',
        'body': 'มาเลื่อนรถด้วยคร้าบ',
      },
      'to': token,
      'priority': 'high',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        title: Text(
          "Scanned Result",
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close_outlined, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 200, left: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "ผลการสแกนหมายเลขทะเบียน",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 26,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            Text(
              "${widget.result}".replaceAll(
                '"',
                '',
              ),
              style: TextStyle(fontSize: 22, color: Colors.black),
            ),
            SizedBox(height: 46),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  onSurface: Colors.blue),
              onPressed: () {
                sendPushMessage();
              },
              child: Text("กดเพื่อเรียกเจ้าของรถยนต์"),
              //child: Text("${widget.phonenumber}".replaceAll('"', '')),
            )
          ],
        ),
        //
      ),
    );
  }

  Future<void> sendPushMessage() async {
    String _token =
        "cKtehwqBQpSe-Wbe_NDoi-:APA91bGiGazbcjIKFfurNyk2VpElYBj9BXyy_dI3BMc4XgSSEHqeVwLP1TweN2CkAp8SoktSXcER0ydI7GW1YEafgaWB9OlLzUuRZ4C9egXuijqlBYvUAcsmvisIXe0dICyz546u4Ix5";
    if (_token == null) {
      print('Unable to send FCM message, no token exists.');
      return;
    }

    try {
      await http.post(
        Uri.parse('https://api.rnfirebase.io/messaging/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'key=AAAAa_2Iw2g:APA91bFzbE3QQzvrWQo2Z3cRs76ndOZcOD78L-KhZld6K-WV9ALn1BKSz0hFlxk45BGQ5Fxn-MF0nL1rJRpqf1GZPUp-t3LFP8391MJ_kYuFddA0426-skqE93m1xo0ZAD5kd3EcsLxx',
        },
        body: constructFCMPayload(_token),
      );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }
}
