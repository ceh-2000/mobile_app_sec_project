import 'package:flutter/material.dart';

class Camera extends StatefulWidget {
  @override
  _Camera createState() => _Camera();
}

class _Camera extends State<Camera> {
  @override
  void initState() {}

  _Camera() {}

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
        body: const Padding(
            padding: EdgeInsets.all(50.0), child: Text('Camera')
        )
    ));
  }
}
