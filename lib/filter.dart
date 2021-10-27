import 'package:flutter/material.dart';
import 'package:mobile_app_sec_project/services/local_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'constants.dart';

class Filter extends StatefulWidget {
  final String docIdsSelected;

  Filter({Key? key, required this.docIdsSelected}) : super(key: key);

  @override
  _Filter createState() => _Filter(docIdsSelected);
}

class _Filter extends State<Filter> {
  // Title of our alert dialog
  final String _title = 'Choose a bill to display on the map:';

  // String that corresponds to what we should mark on the map
  String? _selectedItem = '';

  late List<String> _docIdsAll = [];

  @override
  void initState() {}

  _Filter(docIdsSelected) {
    // TODO: Change this username to the user id pulled from authentication
    getListOfBills((FirebaseAuth.instance.currentUser!).uid).then((List<String> bills){
      setState(() {
        _docIdsAll = bills;
        _selectedItem = docIdsSelected;
      });
    });

  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(_title),
        content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children:
                _docIdsAll.map((bill) => ListTile(
                  title: Text(bill),
                  leading: Radio<String>(
                    value: bill,
                    groupValue: _selectedItem,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedItem = value;
                      });
                    },
                  ),
                )).toList()
            )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _selectedItem);
              },
              child: const Text('Update Map'),
            ),
          ),
        ]));
  }
}
