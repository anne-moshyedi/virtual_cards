import 'package:flutter/material.dart';
import 'package:practice_app/main.dart';

class Notes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child: Text('Notes will go here'),
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}