import 'package:flutter/material.dart';
import 'package:practice_app/main.dart';
import 'package:practice_app/contacts.dart';
import 'package:practice_app/createContact.dart';

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
              //SizedBox(height: 20,),
              Row(
                children: <Widget> [
                  Expanded(
                    child: SizedBox(
                    width: double.infinity,
                    child: RaisedButton.icon(
                      icon: Icon(Icons.add),
                      label:
                        Text("Create another contact card"),
                      color: Colors.cyan[100],
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CreateContact()));
                      },
                      ),
                      )
                    )
                  ]
                ),
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
