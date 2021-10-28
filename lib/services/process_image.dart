import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:mobile_app_sec_project/services/user_location.dart';

import 'cloud_storage.dart';
import 'local_storage.dart';

// Takes in the image as a parameter and outputs the serial number
Future<String> getSerialNumber(image) async {
  // Process text in image
  // Source: https://pub.dev/packages/google_ml_kit
  final inputImage = InputImage.fromFilePath(image.path);
  final textDetector = GoogleMlKit.vision.textDetector();
  final RecognisedText recognisedText = await textDetector.processImage(inputImage);

  // Extract text
  String imageText = recognisedText.text;
  print(imageText);
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

  return matchingText;
}