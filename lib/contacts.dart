import 'package:flutter/material.dart';
import 'package:practice_app/main.dart';

class Contacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child: Text('Contacts will go here'),
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}