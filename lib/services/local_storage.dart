import 'dart:io';
import 'package:path_provider/path_provider.dart';

// Get the location of the private directory only this app can access
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  // For your reference print the AppDoc directory
  print(directory.path);
  return directory.path;
}

// Get the reference to the file location where we will write the bill data
Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/bill_history.txt');
}

// Write a string to the file
Future<File> writeContent(String bill_id) async {
  final file = await _localFile;

  // Write the file
  return file.writeAsString(bill_id);
}

// Read from the file
Future<String> readContent() async {
  try {
    final file = await _localFile;

    // Read the file
    String contents = await file.readAsString();
    return contents;
  } catch (e) {
    // If there is an error reading, return a default String
    return 'Error';
  }
}
