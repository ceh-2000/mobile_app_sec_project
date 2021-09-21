import 'package:flutter/material.dart';

import 'constants.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccount createState() => _CreateAccount();
}

class _CreateAccount extends State<CreateAccount> {
  // Create global form key
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  String _passwordConfirm = '';

  @override
  void initState() {}

  _CreateAccount() {}

  _submitForm() {
    // Check if the correct username and password were entered
    if (_password == _passwordConfirm) {
      // TODO: STORE THE NEWLY CREATED USERNAME AND PASSWORD COMBINATION ON THE DEVICE

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('The password entries don\'t match.')),
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
                                  child: Form(
                                      key: _formKey,
                                      child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            // TODO: Create stipulations on username (i.e. 8 characters, letters and numbers, symbols)
                                            TextFormField(
                                              decoration: const InputDecoration(
                                                  border:
                                                  UnderlineInputBorder(),
                                                  labelText: 'Username'),
                                              maxLength: Constants.maxUsernameLength,
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
                                            // TODO: Create stipulations on password (i.e. 8 characters, letters and numbers, symbols)
                                            TextFormField(
                                              decoration: const InputDecoration(
                                                  border:
                                                  UnderlineInputBorder(),
                                                  labelText: 'Password'),
                                              maxLength: Constants.maxPasswordLength,
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
                                            TextFormField(
                                              decoration: const InputDecoration(
                                                  border:
                                                  UnderlineInputBorder(),
                                                  labelText: 'Confirm Password'),
                                              maxLength: Constants.maxPasswordLength,
                                              obscureText: true,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter some text.';
                                                }
                                                return null;
                                              },
                                              onChanged: (text) {
                                                _passwordConfirm = text;
                                              },
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  // Validate returns true if the form is valid, or false otherwise.
                                                  if (_formKey.currentState!.validate()) {
                                                    _submitForm();
                                                  }
                                                  else {
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      const SnackBar(
                                                          content: Text('Please fill in all fields.')),
                                                    );
                                                  }
                                                },
                                                child: const Text('Submit'),
                                              ),
                                            ),
                                          ]))))
                        ])))));
  }
}
