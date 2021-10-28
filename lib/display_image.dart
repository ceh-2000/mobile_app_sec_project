import 'dart:io';
import 'package:flutter/material.dart';

import 'package:mobile_app_sec_project/services/cloud_storage.dart';
import 'package:mobile_app_sec_project/services/user_location.dart';
import 'package:mobile_app_sec_project/services/local_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'constants.dart';

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final String matchingText;

  DisplayPictureScreen(
      {Key? key, required this.imagePath, required this.matchingText})
      : super(key: key);

  final FocusNode myFocusNode = FocusNode();

  Widget _displayBillId(matchingText, context) {
    TextEditingController myTextEditingController = TextEditingController(text: matchingText);

    return
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Expanded(
            flex: 4,
            child: EditableText(
              autofocus: true,
              backgroundCursorColor: Constants.color2,
              cursorColor: Constants.color2Dark,
              style: const TextStyle(fontSize: 24.0, color: Constants.black, decoration: TextDecoration.underline),
              focusNode: myFocusNode,
              controller: myTextEditingController,
            ),
          ),
          Expanded(
            flex: 1,
            child: ElevatedButton(
              child: Icon(Icons.check, color: Constants.white, size: 24.0),
              onPressed: () async {
                String editedText = myTextEditingController.value.text;

                // Upload serial number both to the cloud and locally
                uploadBillLocation(editedText, await getUserLocation());
                writeBillContent((FirebaseAuth.instance.currentUser!).uid, editedText);

                Navigator.pop(context);
              },
            ),
          ),
        ])
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.color1Light,
        appBar: AppBar(title: const Text('Display the Picture')),
        body: Column(children: [
          Expanded(flex: 3, child: Image.file(File(imagePath))),
          Expanded(flex: 1, child: _displayBillId(matchingText, context))
        ]));
  }
}
