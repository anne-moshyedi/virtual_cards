import 'package:flutter/material.dart';
import 'package:practice_app/main.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child: Text('Settings will go here'),
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}