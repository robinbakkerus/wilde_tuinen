// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wilde_tuinen/model/garden.dart';
import 'package:wilde_tuinen/event/app_events.dart';
import 'package:wilde_tuinen/data/app_data.dart';


class MarkerUtils {
  MarkerUtils() {
    AppEvents.fireMarkersReady(_markers);
  }

  Set<Marker> getMarkers() => _markers;
  Set<Garden> _gardens = Set();

  Set<Marker> _markers = <Marker>{};
  MarkerId? selectedMarker;

  Set<Marker> buildMarkers(BuildContext context) {
    this._gardens = _retrieveGardens();

    this._gardens.forEach((g) {
      final markerId = MarkerId(g.id.toString());
      final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(g.lat, g.lng),
        infoWindow: InfoWindow(title: g.name, snippet: g.name),
        onTap: () {
          _onMarkerTapped(context, markerId);
        },
      );

      _markers.add(marker);
    });

    return _markers;
  }

  void _onMarkerTapped(BuildContext context, MarkerId markId) {
    Garden garden =
        this._gardens.firstWhere((g) => g.id.toString() == markId.value);

    AppData.currentGarden = garden;
    
    showDialog(
      context: context,
      builder: (BuildContext context) => _buildPopupDialog(garden, context),
    );
  }

  Widget _buildPopupDialog(Garden garden, BuildContext context) {
    return new AlertDialog(
      title: Text(garden.name),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(garden.description),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              AppEvents.fireSwitchStack(StackType.MAIN, 1);
            },
            child: const Text('Meer ...'),
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Sluit'),
        ),
      ],
    );
  }

  Set<Garden> _retrieveGardens() {
    // return Future.delayed(Duration(milliseconds: 100), () {
    Set<Garden> r = new Set();

    r.add(_buildGarden(1, 'Abc', 51.41, 5.50, 'Vlindertuin'));
    r.add(_buildGarden(2, 'Def', 51.46, 5.51, 'Mooie tuin'));
    r.add(_buildGarden(3, 'Xys', 51.47, 5.54, 'Blah'));

    return r;
    // });
  }

  Garden _buildGarden(
      int id, String name, double lat, double lng, String descr) {
    Garden g = new Garden();
    g.id = id;
    g.name = name;
    g.lat = lat;
    g.lng = lng;
    g.description = descr;
    return g;
  }
}
