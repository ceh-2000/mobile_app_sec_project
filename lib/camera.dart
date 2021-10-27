import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:mobile_app_sec_project/services/cloud_storage.dart';
import 'package:mobile_app_sec_project/services/user_location.dart';
import 'package:mobile_app_sec_project/services/local_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
                Navigator.pop(context);
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

              // Process text in image
              // Source: https://pub.dev/packages/google_ml_kit
              final inputImage = InputImage.fromFilePath(image.path);
              final textDetector = GoogleMlKit.vision.textDetector();
              final RecognisedText recognisedText = await textDetector.processImage(inputImage);

              // Extract text
              String imageText = recognisedText.text;
              RegExp exp = RegExp(r"[A-NP-Y]?[A-L]\s?\d{8}\s?[A-NP-Y]?"); // identify bill serial number https://www.moneyfactory.gov/resources/serialnumbers.html
              Iterable<RegExpMatch> matches = exp.allMatches(imageText); // source https://stackoverflow.com/questions/27545081/best-way-to-get-all-substrings-matching-a-regexp-in-dart
              String longest = "";
              matches.forEach((match) => ((match.group(0) ?? "").length > longest.length) ? longest = (match.group(0) ?? "") : null); // store the longest segment of matched text
              if (longest == "") {
                longest = "Serial number not found"; // message for if serial not found
              }
              String matchingText = longest.replaceAll(' ', ''); // strip white space for consistency across scans

              // save resources
              textDetector.close();

              // Upload serial number
              uploadBillLocation(matchingText, await getUserLocation());
              writeBillContent((FirebaseAuth.instance.currentUser!).uid, matchingText);

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

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final String matchingText;

  const DisplayPictureScreen({Key? key, required this.imagePath, required this.matchingText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: Column(children: [Image.file(File(imagePath)), Text(matchingText),])
    );
  }
}
