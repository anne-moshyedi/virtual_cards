import 'package:flutter/material.dart';
import 'package:practice_app/main.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child: Text('Cards will go here'),
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}