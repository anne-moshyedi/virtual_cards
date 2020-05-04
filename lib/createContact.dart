import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:practice_app/contacts.dart';
import 'package:practice_app/profile.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:practice_app/databaseConnect.dart';
import 'package:practice_app/contactExpanded.dart';

class CreateContact extends StatelessWidget {
  // add to this Map as the user adds information. then, after the user confirms to create the contact,
  // send this Map to a function in databaseConnect that will actually use SQL to create the contact
    // will need to somehow generate a unique id...
    // need to find a better way to initialize this -- probably card_id = unique number ??
  Map<String, String> contactInfo = {'': ''};
  List<String> fieldNames = ['First Name', 'Last Name', 'Title', 'Company', 'Mobile', 'Email', 'Address', 'LinkedIn', 'Website'];
  List<String> attributeNames = ['f_name', 'l_name', 'title', 'company', 'mobile_number', 'email_addr', 'street_addr', 'linked_in', 'website'];
  @override
  Widget build(BuildContext context) {
    final int len = (fieldNames.length);      
      return Scaffold(
        appBar: AppBar(
          title: Text("Create Contact"),
          actions: [
          //IconButton(
            FlatButton(
            child: Text("done!"), 
            //icon: Icon(Icons.edit),
            onPressed: () {
              return Alert (
                        context: context, 
                        title: "Are you sure you want to create this new contact card?", 
                        buttons: [DialogButton(child: Text("Yes"), onPressed: () {
                          // here i would pass the Map contactInfo to a function that adds it to DB
                          print("here");
                          createCard(contactInfo);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
                        },), DialogButton(child: Text("No"), onPressed: () {
                          Navigator.pop(context);
                        },)]).show();
              //print('do something hurr');
              // Navigator.pop(context);
              //Navigator.push(context, MaterialPageRoute(builder: (context) => ContactExpanded(contactInfo, id)));
            },
          ),
        ],
        ),
        body: new Material (
          child: new Column (
            children: <Widget> [
              new Expanded(flex: 9,
                child: new ListView.builder(
                  padding: const EdgeInsets.all(2),
                  itemCount: len,
                  itemBuilder: (BuildContext context, int index) { 
                      final field = fieldNames[index];
                      final attribute = attributeNames[index];
                      //final info = contactInfo[index*2+1];
                      // if (field == 'Notes') {
                      //   return ListTile (
                      //     title: TextFormField(
                      //       onFieldSubmitted: (text) {
                      //         //updateNotes(text, id);
                      //       },
                      //       textInputAction: TextInputAction.done,
                      //       cursorColor: Colors.cyan,
                      //       //initialValue: '$info',
                      //       style: TextStyle(color: Colors.black54, fontSize: 12),
                      //       maxLines: null,
                      //       decoration: const InputDecoration (
                      //         labelText: 'Notes',
                      //         labelStyle: TextStyle(color: Colors.black, fontSize: 20) 
                      //         ) 
                      //       ),
                      //     leading: Icon(Icons.keyboard) 
                      //     );
                      // }
                      if (field == 'First Name') {
                        return 
                        //ListTile (
                          Row(
                            children: <Widget>[
                            SizedBox(width: 15),
                              Expanded(
                                child: TextFormField(
                                  onChanged: (text) => contactInfo[attribute] = text,
                                  // onFieldSubmitted: (text) {
                                  //   contactInfo[attribute] = text;
                                  //   print(text);
                                  //   print(contactInfo[attribute]);
                                  //   },
                            textInputAction: TextInputAction.done,
                            cursorColor: Colors.cyan,
                            //initialValue: names[1],
                            style: TextStyle(color: Colors.black54, 
                            //fontSize: 12
                            ),
                            maxLines: null,
                            decoration: InputDecoration (
                              labelText: field,
                              labelStyle: TextStyle(color: Colors.black, fontSize: 20) 
                              ) 
                            ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            onChanged: (text) => contactInfo[attribute] = text,
                            // onFieldSubmitted: (text) {
                            //   contactInfo['l_name'] = text;
                            // },
                            textInputAction: TextInputAction.done,
                            cursorColor: Colors.cyan,
                            //initialValue: names[3],
                            style: TextStyle(color: Colors.black54, 
                            //fontSize: 12
                            ),
                            maxLines: null,
                            decoration: InputDecoration (
                              labelText: 'Last Name',
                              labelStyle: TextStyle(color: Colors.black, fontSize: 20) 
                              ) 
                            ),
                        ),
                        SizedBox(width: 10),
                        ],
                        
                        );
                     }
                     // skip over last name, already taken care of
                     if (field == 'Last Name') return SizedBox();
                      return ListTile (
                          title: TextFormField(
                            onChanged: (text) => contactInfo[attribute] = text,
                            // onFieldSubmitted: (text) {
                            //   //print(text);
                            //   contactInfo[attribute] = text;
                            //   //print('hey');
                            //   print(contactInfo[attribute]);
                            // },
                            textInputAction: TextInputAction.done,
                            cursorColor: Colors.cyan,
                            //initialValue: '$info',
                            style: TextStyle(color: Colors.black54, 
                            //fontSize: 12
                            ),
                            maxLines: null,
                            decoration: InputDecoration (
                              labelText: field,
                              labelStyle: TextStyle(color: Colors.black, fontSize: 20) 
                              ) 
                            ),
                          );
                     },
                  ),
                ),
                // new Expanded (
                //   flex: 2,
                //   child: FlatButton (
                //     textColor: Colors.red,
                //     onPressed: () {
                //       return Alert (
                //         context: context, 
                //         title: "Are you sure you want to delete this contact?", 
                //         buttons: [DialogButton(child: Text("Yes"), onPressed: () {
                //           //deleteContact(id);
                //           Navigator.push(context, MaterialPageRoute(builder: (context) => Contacts()));
                //         },), DialogButton(child: Text("No"), onPressed: () {
                //           Navigator.pop(context);
                //         },)]).show();
                //     },
                //     child: Text ('Delete')
                //     )
                //   )
              ]
            )
          )
      ); 
  }
}