import 'package:flutter/material.dart';

class AccessPermissionPage extends StatefulWidget {
  const AccessPermissionPage({Key? key}) : super(key: key);

  @override
  _AccessPermissionPageState createState() => _AccessPermissionPageState();
}

class _AccessPermissionPageState extends State<AccessPermissionPage> {
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
              onPressed: (){},
              child: Text("Activar GPS"),
            ),
          ],
        ),
      ),
    );
  }
}
