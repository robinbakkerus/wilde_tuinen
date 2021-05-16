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
    this._gardens = AppData().gardens;

    this._gardens.forEach((g) {
      final markerId = MarkerId(g.id.toString());
      final icon = _getIcon(g.type);

      final Marker marker = Marker(
        markerId: markerId,
        icon: icon,
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


  BitmapDescriptor _getIcon(GardenType type) {
    if (type == GardenType.VT) {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
    } else {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
    }
  }

  void _onMarkerTapped(BuildContext context, MarkerId markId) {
    Garden garden =
        this._gardens.firstWhere((g) => g.id.toString() == markId.value);

    AppData().currentGarden = garden;
    AppEvents.fireGardenSelected();
    
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
              AppEvents.fireSwitchStack(STACK_DETAIL_PAGE);
              AppEvents.fireGardenSelected();
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

}
