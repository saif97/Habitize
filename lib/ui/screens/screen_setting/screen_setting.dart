import 'package:flutter/material.dart';

class ScreenSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: const Text("Only check habit when major is checked"),
              trailing: Switch(
                onChanged: (v) {},
                value: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
