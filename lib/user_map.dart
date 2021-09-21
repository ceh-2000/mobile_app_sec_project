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
