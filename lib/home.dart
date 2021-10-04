import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'create_account.dart';
import 'map_cam_navigator.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.cameras}) : super(key: key);

  final List<CameraDescription> cameras;

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  // Create global form key
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  String _correctUsername = 'test';
  String _correctPassword = 'test';

  @override
  void initState() {}

  _Home() {}

  _submitForm() {
    // Check if the correct username and password were entered

    // TODO: GET THE CORRECT USERNAME AND CORRECT PASSWORD FROM LOCAL STORAGE
    if (_username == _correctUsername && _password == _correctPassword) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MapCamNavigator(cameras: widget.cameras)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('The username and/or password entered was inccorect.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.background2,
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: SafeArea(
            child: Center(
                child: Container(
                    margin: const EdgeInsets.all(20.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              child: Image.asset('assets/images/dollars.png'),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Form(
                                      key: _formKey,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            TextFormField(
                                              decoration: const InputDecoration(
                                                  border:
                                                      UnderlineInputBorder(),
                                                  labelText: 'Username'),
                                              maxLength:
                                                  Constants.maxUsernameLength,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter some text.';
                                                }
                                                return null;
                                              },
                                              onChanged: (text) {
                                                _username = text;
                                              },
                                            ),
                                            TextFormField(
                                              decoration: const InputDecoration(
                                                  border:
                                                      UnderlineInputBorder(),
                                                  labelText: 'Password'),
                                              maxLength:
                                                  Constants.maxPasswordLength,
                                              obscureText: true,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter some text.';
                                                }
                                                return null;
                                              },
                                              onChanged: (text) {
                                                _password = text;
                                              },
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16.0),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  // Validate returns true if the form is valid, or false otherwise.
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    _submitForm();
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                          content: Text(
                                                              'Please fill in all fields.')),
                                                    );
                                                  }
                                                },
                                                child: const Text('Submit'),
                                              ),
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CreateAccount()),
                                                  );
                                                },
                                                child: const Text(
                                                    'Create a new account',
                                                    style: TextStyle(
                                                      color: Constants.color1,
                                                      decoration: TextDecoration
                                                          .underline,
                                                    )))
                                          ]))))
                        ])))));
  }
}
