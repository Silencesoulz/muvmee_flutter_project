import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial/camera/cameraview.dart';
import 'package:path/path.dart';
// import 'package:flutter_phone_direct_call/flutter_phone_direct_call.dart';

class ScanPage extends StatefulWidget {
  final result;
  final phonenumber;
  const ScanPage(this.result, this.phonenumber);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    final number = '0814851591';

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
            SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  onSurface: Colors.blue),
              onPressed: () async {
                //  FlutterPhoneDirectCall.callNumber(number);
              },
              child: Text("ติดต่อเจ้าของรถยนต์"),
              //child: Text("${widget.phonenumber}".replaceAll('"', '')),
            )
          ],
        ),
        //
      ),
    );
  }
}
