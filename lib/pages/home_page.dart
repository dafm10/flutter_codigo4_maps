import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_codigo4_maps/util/map_style.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Map<MarkerId, Marker> _markers = {};

  /*CameraPosition cameraPosition = CameraPosition(
    target: LatLng(-8.059236, -79.052545),
    zoom: 15,
  );*/

  late CameraPosition cameraPosition;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initCurrentPosition();
    //getPermission();
  }

  getPermission() async {
    PermissionStatus status = await Permission.location.status;
    //print(status);
  }

  Future<CameraPosition> initCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition();
    cameraPosition = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 15.0,
    );
    return cameraPosition;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Maps"),
      ),
      body: FutureBuilder(
        future: initCurrentPosition(),
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (snap.hasData) {
            return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: cameraPosition,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  compassEnabled: true,
                  mapToolbarEnabled: true,
                  mapType: MapType.normal,
                  onMapCreated: (GoogleMapController controller) {
                    controller.setMapStyle(jsonEncode(mapStyle));
                  },
                  // con .toSet() converie los marcadores
                  // con values solo adquiero los valores del mapa
                  markers: _markers.values.toSet(),
                  onTap: (LatLng position) async {
                    final BitmapDescriptor _icon =
                    await BitmapDescriptor.fromAssetImage(
                        const ImageConfiguration(), 'assets/icons/fire.png');
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
                          //print(newLocation);
                        },
                        onTap: () {
                          //print("Hola");
                        });
                    _markers[_markerId] = _marker;
                    setState(() {});
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                    height: 50.0,
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {

                      },
                      icon: Icon(Icons.location_on),
                      label: Text("My Location"),),
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
