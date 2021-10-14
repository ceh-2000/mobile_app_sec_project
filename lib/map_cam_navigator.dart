import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_sec_project/user_map.dart';

import 'camera.dart';
import 'constants.dart';

/// Current intermediate landing page to decide which page user wants to view
/// (login/out, menteeScrollView, profileView) depending on BottomNavigationView
class MapCamNavigator extends StatefulWidget {
  const MapCamNavigator({Key? key, required this.cameras}) : super(key: key);

  final List<CameraDescription> cameras;

  @override
  _MapCamNavigator createState() => _MapCamNavigator();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MapCamNavigator extends State<MapCamNavigator> {
  // Index of which view to show from list of widget options
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // List of pages we could show
    final List<Widget> _widgetOptions = <Widget>[
      UserMap(),
      Camera(cameras: widget.cameras),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Constants.color1Light,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Camera',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Constants.color2Dark,
        unselectedItemColor: Constants.color1Dark,
        onTap: _onItemTapped,
      ),
    );
  }
}
