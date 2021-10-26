import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mobile_app_sec_project/services/user_location.dart';

import 'constants.dart';
import 'filter.dart';
import 'package:mobile_app_sec_project/services/local_storage.dart';

class UserMap extends StatefulWidget {
  const UserMap({Key? key}) : super(key: key);

  @override
  _UserMap createState() => _UserMap();
}

class _UserMap extends State<UserMap> {
  // Get data to display from Firestore
  final Stream<QuerySnapshot> _billsStream =
      FirebaseFirestore.instance.collection('bills').snapshots();

  // This will be the reference to the map
  late GoogleMapController _controller;

  // Set the initial center of the map as the user's position
  // TODO: Pull the user's location and set the initial position as such
  CameraPosition _kLocation =
      const CameraPosition(target: LatLng(37.2711, -76.7163), zoom: 11.0);

  BitmapDescriptor? _pinLocationIcon;

  late Set<Marker> _mapMarkers;

  String _docIdSelected = '';

  @override
  void initState() {
    super.initState();
    getListOfBills(Constants.testUsername).then((List<String> bills){
      setState(() {
        _docIdSelected = bills[bills.length - 1];
      });
    });
  }

  // Once we have the data from Firebase, create a list of markers to go on our map
  Set<Marker> _createMarkerList(snapshot) {
    List<dynamic> geopoints = [];

    snapshot.data!.docs.forEach((doc) {
      if (_docIdSelected == doc.id) {
        geopoints = doc['bill_id'];
      }
    });

    List<LatLng> latLongPoints = [];
    geopoints.forEach((point) {
      latLongPoints.add(LatLng(point.latitude, point.longitude));
    });

    Set<Marker> markers = Set();
    for (int i = 0; i < latLongPoints.length; i++) {
      MarkerId markerId = MarkerId('Marker $i');

      if (_pinLocationIcon != null) {
        markers.add(Marker(
          markerId: markerId,
          position: latLongPoints[i],
          infoWindow: InfoWindow(title: 'Marker $i'),
          icon: _pinLocationIcon!,
        ));
      } else {
        markers.add(Marker(
          markerId: markerId,
          position: latLongPoints[i],
          infoWindow: InfoWindow(title: 'Marker $i'),
        ));
      }
    }

    return markers;
  }

  // Change the camera's position to center on the user's location
  Future<void> _setUserLocation() async {
    LocationData? loc = await getUserLocation();
    if(loc != null){
      double? lat = loc.latitude;
      double? lon = loc.longitude;
      if(lat != null && lon != null){
        print('User\'s position: '+lat.toString()+', '+lon.toString());
        CameraPosition newPos = CameraPosition(target: LatLng(lat, lon), zoom: 11.0);
        _controller.animateCamera(CameraUpdate.newCameraPosition(newPos));
        setState(() {
          _kLocation = newPos;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: StreamBuilder<QuerySnapshot>(
            stream: _billsStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      title: const Text('Map'),
                      actions: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.filter_alt_outlined),
                          tooltip: 'Filter Map Display',
                          onPressed: () {
                            // TODO: Add a toast that says that filter results are still loading
                          },
                        ),
                      ],
                    ),
                    body: const Center(
                        child: CircularProgressIndicator(
                            strokeWidth: 5.0, color: Constants.color1)));
              }

              _mapMarkers = _createMarkerList(snapshot);

              return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: const Text('Map'),
                  actions: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.filter_alt_outlined),
                      tooltip: 'Filter Map Display',
                      onPressed: () async {
                        // Display the popup modal with filtering
                        String newBillId = await showDialog(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return Filter(docIdsSelected: _docIdSelected);
                          },
                        );
                        setState(() {
                          _docIdSelected = newBillId;
                          _mapMarkers = _createMarkerList(snapshot);
                        });
                      },
                    ),
                  ],
                ),
                body: GoogleMap(
                    markers: _mapMarkers,
                    mapType: MapType.hybrid,
                    onMapCreated: (GoogleMapController controller) {
                      _controller = controller;
                    },
                    initialCameraPosition: _kLocation),
                floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
                floatingActionButton: FloatingActionButton(
                  onPressed: (){
                    _setUserLocation();
                  },
                  child: const Icon(Icons.home),
                  backgroundColor: Constants.color2,
                  tooltip: 'Recenter on your location.',
                ),
              );
            }));
  }
}
