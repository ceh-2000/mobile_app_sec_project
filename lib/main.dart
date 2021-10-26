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
  // TODO: Write this bill id when a picture of the bill is taken and the ID is extracted
  await writeContent('');
  await writeBillContent(Constants.testUsername, '54321');
  await writeBillContent(Constants.testUsername, '12345');

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
      home: MyHomePage(
          title: 'Home', cameras: cameras), // MyHomePage used to be const
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.cameras})
      : super(key: key);
  final String title;
  final List<CameraDescription> cameras;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Initial Screen'),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Home(cameras: widget.cameras)),
                  );
                },
                child: const Text('Home'),
              ),
              const SizedBox(height: 30),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MapCamNavigator(cameras: widget.cameras)),
                  );
                },
                child: const Text('Camera/Map'),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserMap()),
                  );
                },
                child: const Text('Just Map'),
              ),
            ])));
  }
}
