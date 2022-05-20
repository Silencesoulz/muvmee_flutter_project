import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial/camera/cameraview.dart';
import 'package:path/path.dart';

class ScanPage extends StatefulWidget {
  final result;
  const ScanPage(this.result);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      appBar: AppBar(
        title: Text(
          "Scanned Result",
          style: TextStyle(color: Colors.black),
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
        padding: const EdgeInsets.only(top: 20, left: 140),
        child: Column(
          children: [
            Text(
              "${widget.result}",
              style: TextStyle(fontSize: 28, color: Colors.black),
            ),
            SizedBox(height: 64),
            Text(
              "ติดต่อเจ้าของรถยนต์",
              style: TextStyle(fontSize: 18, color: Colors.green),
              textAlign: TextAlign.center,
            )
          ],
        ),
        //
      ),
    );
  }
}
