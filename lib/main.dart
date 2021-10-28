import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile_app_sec_project/services/local_storage.dart';

import 'user_map.dart';
import 'constants.dart';
import 'create_account.dart';
import 'home.dart';
import 'map_cam_navigator.dart';

void main() async {
  // Bind before initializing
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase app
  await Firebase.initializeApp();

  // Get the cameras
  final cameras = await availableCameras();

  // Write something to our bill file for testing purposes
  // This is pre-loaded data to get a sense of how the app works
  await writeContent('');
  await writeBillContent('NHnNFmeU7lPhQhgtgxouoKvaOJx1', '54321');
  await writeBillContent('NHnNFmeU7lPhQhgtgxouoKvaOJx1', '12345');

  // Start rendering the UI
  runApp(MyApp(cameras: cameras)); // MyApp used to be const here
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.cameras}) : super(key: key);

  final List<CameraDescription> cameras;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Follow the Money',
      theme: ThemeData(
        primarySwatch: Constants.kToDark,
      ),
      home: Home(cameras: cameras), // MyHomePage used to be const
    );
  }
}
