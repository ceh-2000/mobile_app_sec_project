import 'package:flutter/material.dart';
import 'package:mobile_app_sec_project/user_map.dart';

import 'camera.dart';
import 'constants.dart';

/// Current intermediate landing page to decide which page user wants to view
/// (login/out, menteeScrollView, profileView) depending on BottomNavigationView
class MapCamNavigator extends StatefulWidget {
  @override
  _MapCamNavigator createState() => _MapCamNavigator();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MapCamNavigator extends State<MapCamNavigator> {
  // List of pages we could show
  final List<Widget> _widgetOptions = <Widget>[
    Camera(),
    UserMap(),
  ];

  // Index of which view to show from list of widget options
  int _selectedIndex = 0;

  late PageController _pageController; // = PageController();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      // Animated transition from one screen to the next
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _selectedIndex = index);
              },
              children: _widgetOptions)),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Constants.color1Light,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Map',
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
