import 'package:flutter/material.dart';
import 'package:practice_app/main.dart';
import 'package:practice_app/contacts.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.search), 
            onPressed: () {
              showSearch(
                context: context, 
                delegate: CustomSearchDelegate(ContactList('',''), '1')
              );
            },
          ),
        ],
      ),
        body: new Material(
          child: new Column(
            children: <Widget>[
              new Expanded(
                flex: 2,
                child: ContactList('1', ''),
              ),
             ]
            )
          ),
        drawer: MyDrawer(),
    );
  }
}
