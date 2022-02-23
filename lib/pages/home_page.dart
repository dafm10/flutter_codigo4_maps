import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_codigo4_maps/util/map_style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Map<MarkerId, Marker> _markers = {};

  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(-8.059236, -79.052545),
    zoom: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Maps"),
      ),
      body: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          controller.setMapStyle(jsonEncode(mapStyle));
        },
        // con .toSet() converie los marcadores
        markers: _markers.values.toSet(),
        onTap: (LatLng position){
          MarkerId _markerId = MarkerId(_markers.length.toString());
          // creamos un marcador
          Marker _marker = Marker(
              markerId: _markerId,
            position: position,
          );
          _markers[_markerId] = _marker;
          setState(() {

          });
        },
      ),
    );
  }
}
