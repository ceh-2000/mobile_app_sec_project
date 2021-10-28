import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  // This key will allow us to add popup messages
  final _formKey = GlobalKey<FormState>();

  // These will hold the username and password of the person trying to log in
  String _username = '';
  String _password = '';

  late FirebaseAuth _auth;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
  }

  // Subscribe to get up-to-date auth changes
  void subscribeToAuthChanges() {
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  // Once we know that the person trying to login is allowed, we authenticate them with Firebase
  _submitForm() async {
    // Check if the correct username and password were entered
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _username, password: _password);

      // If this succeeds, user's account is created AND user is logged in
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MapCamNavigator(cameras: widget.cameras)),
      );
    } on FirebaseAuthException catch (e) {
      print('hi' + e.code);
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No user was found for that email.')),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('The wrong password provided for that user.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('We were unable to log you in.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            backgroundColor: Constants.background2,
            appBar: AppBar(
              automaticallyImplyLeading: false,
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
                                  child:
                                      Image.asset('assets/images/dollars.png'),
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                      padding: EdgeInsets.all(10.0),
                                      child: Form(
                                          key: _formKey,
                                          child: SingleChildScrollView(
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                TextFormField(
                                                  decoration: const InputDecoration(
                                                      border:
                                                          UnderlineInputBorder(),
                                                      labelText: 'Username'),
                                                  maxLength: Constants
                                                      .maxUsernameLength,
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
                                                  maxLength: Constants
                                                      .maxPasswordLength,
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
                                                  padding: const EdgeInsets
                                                          .symmetric(
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
                                                                CreateAccount(
                                                                    cameras: widget
                                                                        .cameras)),
                                                      );
                                                    },
                                                    child: const Text(
                                                        'Create a new account',
                                                        style: TextStyle(
                                                          color:
                                                              Constants.color1,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                        )))
                                              ])))))
                            ]))))));
  }
}
