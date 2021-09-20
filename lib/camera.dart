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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Camera'),
        ),
        body: const Padding(
            padding: EdgeInsets.all(50.0), child: Text('Camera')
        )
    );
  }
}
