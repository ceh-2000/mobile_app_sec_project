import 'package:flutter/material.dart';

import 'filter.dart';

class UserMap extends StatefulWidget {
  @override
  _UserMap createState() => _UserMap();
}

class _UserMap extends State<UserMap> {
  @override
  void initState() {}

  _UserMap() {}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Map'),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.filter_alt_outlined),
                tooltip: 'Filter Map Display',
                onPressed: () {
                  // Display the popup modal with filtering

                  // TODO: Pass an initial state to the map (or pull from user preferences on device)
                  // TODO: Get back what the user selected and render the updated map with new markers
                  showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return Filter();
                    },
                  );
                },
              ),
            ],
          ),
          body: const Padding(
              padding: EdgeInsets.all(50.0), child: Text('User Map')),
        ));
  }
}
