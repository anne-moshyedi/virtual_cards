import 'package:flutter/material.dart';
import 'package:practice_app/main.dart';
import 'package:practice_app/contacts.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        actions: [
          IconButton(
            icon: Icon(Icons.search), 
            onPressed: () {
              showSearch(
                context: context, 
                delegate: CustomSearchDelegate(ContactList('',''), '0 OR personal = 1')
              );
            },
          ),
        ],
      ),
        drawer: MyDrawer(),
    );
  }
}