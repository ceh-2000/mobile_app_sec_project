import 'package:flutter/material.dart';

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
    return Scaffold(
        appBar: AppBar(
          title: const Text('User Map'),
        ),
        body: const Padding(
            padding: const EdgeInsets.all(50.0), child: const Text('User Map')
        )
    );
  }
}
