import 'package:flutter/material.dart';
import 'package:practice_app/main.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child: Text('Search will go here'),
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}