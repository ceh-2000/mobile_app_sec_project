import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccount createState() => _CreateAccount();
}

class _CreateAccount extends State<CreateAccount> {
  @override
  void initState() {}

  _CreateAccount() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Account'),
        ),
        body: const Padding(
            padding: EdgeInsets.all(50.0), child: Text('Create Account')
        )
    );
  }
}
