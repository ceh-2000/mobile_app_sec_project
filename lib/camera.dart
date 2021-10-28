import 'dart:async';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'services/process_image.dart';
import 'display_image.dart';

// credit: https://flutter.dev/docs/cookbook/plugins/picture-using-camera
class Camera extends StatefulWidget {
  const Camera({Key? key, required this.cameras}) : super(key: key);

  final List<CameraDescription> cameras;

  @override
  CameraState createState() => CameraState();
}

class CameraState extends State<Camera> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.cameras.first,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  void _signOut() async {
    final _firebaseAuth = FirebaseAuth.instance;

    print('Trying to log out user.');
    final User? user = _firebaseAuth.currentUser;
    if (user == null) {
      return;
    }

    await _firebaseAuth.signOut();

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Home(cameras: widget.cameras)));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Camera'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Logout',
              onPressed: () {
                _signOut();
              },
            ),
          ],
        ),
        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the Future is complete, display the preview.
              return CameraPreview(_controller);
            } else {
              // Otherwise, display a loading indicator.
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          // Provide an onPressed callback.
          onPressed: () async {
            // Take the Picture in a try / catch block. If anything goes wrong,
            // catch the error.
            try {
              // Ensure that the camera is initialized.
              await _initializeControllerFuture;

              // Attempt to take a picture and get the file `image`
              // where it was saved.
              final image = await _controller.takePicture();

              // Use the process_image service to pull out the serial number
              String matchingText = await getSerialNumber(image);

              // If the picture was taken, display it on a new screen.
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DisplayPictureScreen(
                    // Pass the automatically generated path to
                    // the DisplayPictureScreen widget.
                    imagePath: image.path,
                    matchingText: matchingText,
                  ),
                ),
              );
            } catch (e) {
              // If an error occurs, log the error to the console.
              print(e);
            }
          },
          child: const Icon(Icons.camera_alt),
        ),
      ),
    );
  }
}
