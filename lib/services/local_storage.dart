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
Future<File> writeContent(String content) async {
  final file = await _localFile;

  // Write the user who uploaded the bill and the bill's id to local storage
  return file.writeAsString(content);
}

// Write a bill information to the file
Future<File> writeBillContent(String username, String bill_id) async {
  final file = await _localFile;

  final String currentFileContent = await readContent();
  print('Current file contents: '+currentFileContent);

  // Write the user who uploaded the bill and the bill's id to local storage
  return file.writeAsString(currentFileContent+username+':'+bill_id+'\n');
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

// Get bills uploaded by a specific user from local storage
Future<List<String>> getListOfBills(String username) async {
  try {
    final file = await _localFile;

    // Read the file
    String contents = await file.readAsString();
    contents = contents.trim();
    print(contents);

    List<String> listOfBillIds = [];
    List<String> contentsList = contents.split('\n');
    contentsList.forEach((element) {
      String curUsername = element.split(':')[0];
      String billId = element.split(':')[1];
      if(curUsername == username){
        listOfBillIds.add(billId);
      }
    });

    return listOfBillIds.toSet().toList();
  } catch (e) {
    // If there is an error reading, return a default String
    return ['Error'];
  }
}
