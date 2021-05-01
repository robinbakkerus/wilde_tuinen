import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:wilde_tuinen/data/app_data.dart';
import 'package:wilde_tuinen/util/marker_utils.dart';
import 'package:wilde_tuinen/event/app_events.dart';
// import 'dart:developer'; 

class HomePage extends StatefulWidget {
  HomePage({required this.title}) : super();

  final String title;

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState() {
    _mu = MarkerUtils();
    AppEvents.onMarkersReady(this._onMarkersReady);
  }

  late MarkerUtils _mu;
  late GoogleMapController _mapController;
  double _lat = 13.0827;
  double _lng = 80.2707;

  Location location = new Location();
  late LocationData _locationData;
  bool _serviceEnabled = false;
  PermissionStatus? _permissionGranted;

  final LatLng _center = const LatLng(0.0, 0.677433);
  double _zoom = 2.0;

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _searchNearby(51.5, 5.5);
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: _zoom,
      ),
      markers: _buildMarkers(context),
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      padding: EdgeInsets.only(
        top: 140.0,
      ),
    );
  }

  void _searchNearby(double latitude, double longitude) async {
    setState(() {
      _locateMe();
    });
  }

  _locateMe() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    _lat = _locationData.latitude ?? 0.0;
    _lng = _locationData.longitude ?? 0.0;

    final _position = CameraPosition(
      target: LatLng(_lat, _lng),
      zoom: 12,
    );
    
    _mapController.animateCamera(CameraUpdate.newCameraPosition(_position));
    setState(() {
      _lat = _locationData.latitude ?? 0.0;
      _lng = _locationData.longitude ?? 0.0;
    });

    location.onLocationChanged.listen((LocationData locdata) {
      AppData().newGarden.lat = locdata.latitude as double;
      AppData().newGarden.lng = locdata.longitude as double;

      // log('lat = ' + AppData().newGarden.lat.toString());
    });
  }

  void _onMarkersReady(MarkersReadyEvent event) {
    setState(() {
      _zoom = 10;
    });
  }

  _buildMarkers(BuildContext context) {
    return _mu.buildMarkers(context);
  }
}
