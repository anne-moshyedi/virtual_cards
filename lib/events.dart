import 'package:flutter/material.dart';
import 'package:practice_app/main.dart';

class Events extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Events"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child: Text('Events will go here'),
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}