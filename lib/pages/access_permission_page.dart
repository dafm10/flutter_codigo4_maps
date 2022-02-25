import 'package:flutter/material.dart';
import 'package:flutter_codigo4_maps/pages/home_page.dart';
import 'package:permission_handler/permission_handler.dart';

class AccessPermissionPage extends StatefulWidget {
  const AccessPermissionPage({Key? key}) : super(key: key);

  @override
  _AccessPermissionPageState createState() => _AccessPermissionPageState();
}

class _AccessPermissionPageState extends State<AccessPermissionPage> {
  checkPermission(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
        break;
      case PermissionStatus.denied:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.limited:
      case PermissionStatus.restricted:
        openAppSettings();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Access Permission"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                PermissionStatus status = await Permission.location.request();
                checkPermission(status);
              },
              child: const Text("Activar GPS"),
            ),
          ],
        ),
      ),
    );
  }
}
