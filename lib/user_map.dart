import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'constants.dart';
import 'filter.dart';

class UserMap extends StatefulWidget {
  @override
  _UserMap createState() => _UserMap();
}

class _UserMap extends State<UserMap> {
  // This will be the reference to the map
  late GoogleMapController _controller;

  // Set the initial center of the map --> maybe pull the user's location for this
  final CameraPosition _kInitialPosition =
      CameraPosition(target: LatLng(-33.852, 151.211), zoom: 11.0);

  final CameraPosition _kLocation = const CameraPosition(
      target: LatLng(37.2707, -76.7075),
      zoom: 11.0
      );

  @override
  void initState() {}

  _UserMap() {}

  Future<void> _goToMyLocation() async {
    _controller.animateCamera(CameraUpdate.newCameraPosition(_kLocation));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Map'),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.filter_alt_outlined),
                tooltip: 'Filter Map Display',
                onPressed: () {
                  // Display the popup modal with filtering

                  // TODO: Pass an initial state to the map (or pull from user preferences on device)
                  // TODO: Get back what the user selected and render the updated map with new markers
                  showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return Filter();
                    },
                  );
                },
              ),
            ],
          ),
          body: GoogleMap(
              mapType: MapType.hybrid,
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
              },
              initialCameraPosition: _kInitialPosition),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: _goToMyLocation,
            child: const Icon(Icons.home),
            backgroundColor: Constants.color2,
          ),
        ));
  }
}
