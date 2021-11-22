import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial/google_sign_in.dart';
import 'package:flutter_tutorial/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

List<CameraDescription> cameras = [];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          title: 'MuvMee',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SplashScreen(),
        ),
      );
}
