import 'package:flutter/material.dart';

class Filter extends StatefulWidget {
  // TODO: Accept input of initial value to display

  @override
  _Filter createState() => _Filter();
}

class _Filter extends State<Filter> {
  // Title of our alert dialog
  String _title = 'Choose what to show on map';

  // String that corresponds to what we should mark on the map
  String? _selectedItem = 'all_bills';

  @override
  void initState() {}

  _Filter() {}

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(_title),
        content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          // TODO: Pull these options from storage on the user's device
          ListTile(
            title: const Text('All bills ever entered'),
            leading: Radio<String>(
              value: 'all_bills',
              groupValue: _selectedItem,
              onChanged: (String? value) {
                setState(() {
                  _selectedItem = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Bill with ID: ABCDE'),
            leading: Radio<String>(
              value: 'ABCDE',
              groupValue: _selectedItem,
              onChanged: (String? value) {
                setState(() {
                  _selectedItem = value;
                });
              },
            ),
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
