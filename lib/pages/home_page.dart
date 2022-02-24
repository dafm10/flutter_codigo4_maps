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
        // con values solo adquiero los valores del mapa
        markers: _markers.values.toSet(),
        onTap: (LatLng position) async {
          final BitmapDescriptor _icon = await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(), 'assets/icons/fire.png');
          MarkerId _markerId = MarkerId(_markers.length.toString());
          // creamos un marcador
          Marker _marker = Marker(
              markerId: _markerId,
              position: position,
              //icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
              //icon: BitmapDescriptor.defaultMarkerWithHue(200),
              icon: _icon,
              rotation: -10.0,
              // rotacuón del marcador
              draggable: true,
              onDragEnd: (LatLng newLocation) {
                print(newLocation);
              },
              onTap: () {
                print("Hola");
              });
          _markers[_markerId] = _marker;
          setState(() {});
        },
      ),
    );
  }
}
