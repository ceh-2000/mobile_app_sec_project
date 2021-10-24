import 'package:flutter/material.dart';
import 'package:mobile_app_sec_project/services/local_storage.dart';

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
  String? _selectedItem = '12345';

  late List<String> _docIdsAll = ['12345', '78910', '54321'];

  @override
  void initState() {}

  _Filter(docIdsSelected) {
    // TODO: Pull docIdsAll from local storage
    readContent().then((String bills){
      setState(() {
        print(bills);
        _docIdsAll = [bills];
      });
    });

    _selectedItem = docIdsSelected;
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(_title),
        content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          // TODO: Pull these options from storage on the user's device
          // ListView(
          //     children: _docIdsAll.map((String docId) {
          //   return Center(child: _getListTile(docId));
          // }).toList()),
          Container(
            child: SingleChildScrollView(
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
