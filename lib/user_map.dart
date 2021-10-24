import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'constants.dart';
import 'filter.dart';

class UserMap extends StatefulWidget {
  @override
  _UserMap createState() => _UserMap();
}

class _UserMap extends State<UserMap> {
  // Get data to display from Firestore
  // TODO: Only pull the data for the bills that should be shown on map
  final Stream<QuerySnapshot> _billsStream =
      FirebaseFirestore.instance.collection('bills').snapshots();

  // This will be the reference to the map
  late GoogleMapController _controller;

  // Set the initial center of the map --> maybe pull the user's location for this
  final CameraPosition _kInitialPosition =
      CameraPosition(target: LatLng(-33.852, 151.211), zoom: 11.0);

  final CameraPosition _kLocation =
      const CameraPosition(target: LatLng(37.2707, -76.7075), zoom: 11.0);

  BitmapDescriptor? _pinLocationIcon;

  @override
  void initState() {
    super.initState();
    setCustomMapPin();
  }

  void setCustomMapPin() async {
    _pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/destination_map_marker.png');
  }

  Future<void> _goToMyLocation() async {
    _controller.animateCamera(CameraUpdate.newCameraPosition(_kLocation));
  }

  // Once we have the data from Firebase, create a list of markers to go on our map
  Set<Marker> _createMarkerList(snapshot){

    List<dynamic> geopoints = [];
    snapshot.data!.docs.forEach((doc) =>
      geopoints = doc['bill_id']
    );

    List<LatLng> latLongPoints = [];
    geopoints.forEach((point) {
      latLongPoints.add(LatLng(point.latitude, point.longitude));
    });

    Set<Marker> markers = Set();
    for(int i = 0; i < latLongPoints.length; i++){
      MarkerId markerId = MarkerId('Marker $i');

      // TODO: Get custom pins to show up correctly
      if(_pinLocationIcon != null){
        markers.add(Marker(
          markerId: markerId,
          position: latLongPoints[i],
          infoWindow: InfoWindow(title: 'Marker $i'),
          icon: _pinLocationIcon!,
        ));
      }
      else{
        markers.add(Marker(
          markerId: markerId,
          position: latLongPoints[i],
          infoWindow: InfoWindow(title: 'Marker $i'),
        ));
      }
    }

    return markers;
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
          body: StreamBuilder<QuerySnapshot>(
              stream: _billsStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(
                      strokeWidth: 5.0, color: Constants.color1));
                }

                Set<Marker> mapMarkers = _createMarkerList(snapshot);

                return GoogleMap(
                    markers: mapMarkers,
                    mapType: MapType.hybrid,
                    onMapCreated: (GoogleMapController controller) {
                      _controller = controller;
                    },
                    initialCameraPosition: _kInitialPosition);
              }),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: _goToMyLocation,
            child: const Icon(Icons.home),
            backgroundColor: Constants.color2,
          ),
        ));
  }
}
