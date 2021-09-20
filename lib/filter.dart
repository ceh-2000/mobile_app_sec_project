import 'package:flutter/material.dart';

class Filter extends StatefulWidget {
  @override
  _Filter createState() => _Filter();
}

class _Filter extends State<Filter> {
  @override
  void initState() {}

  _Filter() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Filter'),
        ),
        body: const Padding(
            padding: EdgeInsets.all(50.0), child: Text('Filter')
        )
    );
  }
}
