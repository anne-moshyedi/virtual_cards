import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:practice_app/contacts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:practice_app/databaseConnect.dart';
import 'package:practice_app/contactExpanded.dart';

class ContactExpandedEditable extends StatelessWidget {
  final List<String> contactInfo;
  final String id;
  final names;

  const ContactExpandedEditable(this.contactInfo, this.id, this.names);

  @override
  Widget build(BuildContext context) {
    final int len = (contactInfo.length/2).floor();      
      return Scaffold(
        appBar: AppBar(
          title: Text(contactInfo[1]),
          actions: [
          //IconButton(
            FlatButton(
            child: Text("done!"), 
            //icon: Icon(Icons.edit),
            onPressed: () {
              //print('do something hurr');
              Navigator.pop(context);
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
                      final field = contactInfo[index*2];
                      final info = contactInfo[index*2+1];
                      if (field == 'Notes') {
                        return ListTile (
                          title: TextFormField(
                            onFieldSubmitted: (text) {
                              updateNotes(text, id);
                            },
                            textInputAction: TextInputAction.done,
                            cursorColor: Colors.cyan,
                            initialValue: '$info',
                            style: TextStyle(color: Colors.black54, fontSize: 12),
                            maxLines: null,
                            decoration: const InputDecoration (
                              labelText: 'Notes',
                              labelStyle: TextStyle(color: Colors.black, fontSize: 20) 
                              ) 
                            ),
                          leading: Icon(Icons.keyboard) 
                          );
                      }
                      if (field == 'Name') {
                        return 
                        //ListTile (
                          Row(
                            children: <Widget>[
                            SizedBox(width: 15),
                              Expanded(
                                child: TextFormField(
                                  onFieldSubmitted: (text) {
                                    //print("ill call a generic update here that takes in the field and the new text");
                                    update(text, 'f_name', id);
                                    },
                            textInputAction: TextInputAction.done,
                            cursorColor: Colors.cyan,
                            initialValue: names[1],
                            style: TextStyle(color: Colors.black54, 
                            //fontSize: 12
                            ),
                            maxLines: null,
                            decoration: InputDecoration (
                              labelText: 'First Name',
                              labelStyle: TextStyle(color: Colors.black, fontSize: 20) 
                              ) 
                            ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            onFieldSubmitted: (text) {
                              //print("ill call a generic update here that takes in the field and the new text");
                              update(text, 'l_name', id);
                            },
                            textInputAction: TextInputAction.done,
                            cursorColor: Colors.cyan,
                            initialValue: names[3],
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
                        
                        //);
                     }
                    //   if (field == 'Name') {
                    //     return ListTile (
                    //       title: TextFormField(
                    //         onFieldSubmitted: (text) {
                    //           //print("ill call a generic update here that takes in the field and the new text");
                    //           update(text, field, id);
                    //         },
                    //         textInputAction: TextInputAction.done,
                    //         cursorColor: Colors.cyan,
                    //         initialValue: names[1],
                    //         style: TextStyle(color: Colors.black54, 
                    //         //fontSize: 12
                    //         ),
                    //         maxLines: null,
                    //         decoration: InputDecoration (
                    //           labelText: 'First Name',
                    //           labelStyle: TextStyle(color: Colors.black, fontSize: 20) 
                    //           ) 
                    //         ),
                    //       );
                    //  }
                      
                      
                    //   if (field == 'Mobile') {
                    //     return ListTile (
                    //       title: Text('$field'),
                    //       subtitle: Text('$info'),
                    //     );
                    //   }
                    //   if (field == 'Email') {
                    //     return ListTile (
                    //       title: Text('$field'),
                    //       subtitle: Text('$info'),

                    //     );
                    //   }
                    //   if (field == 'Address') {
                    //     return ListTile (
                    //       title: Text('$field'),
                    //       subtitle: Text('$info'),
                    //     );
                    //   }
                    //   if (field == 'LinkedIn' || field == 'Website') {
                    //     return ListTile (
                    //       title: Text('$field'),
                    //       subtitle: Text('$info'),
                          
                    //     );
                    //   }
                    //   return ListTile(
                    //     title: Text('$field'),
                    //     subtitle: Text('$info'),
                    //   );
                      return ListTile (
                          title: TextFormField(
                            onFieldSubmitted: (text) {
                              //print("ill call a generic update here that takes in the field and the new text");
                              update(text, field, id);
                            },
                            textInputAction: TextInputAction.done,
                            cursorColor: Colors.cyan,
                            initialValue: '$info',
                            style: TextStyle(color: Colors.black54, 
                            //fontSize: 12
                            ),
                            maxLines: null,
                            decoration: InputDecoration (
                              labelText: '$field',
                              labelStyle: TextStyle(color: Colors.black, fontSize: 20) 
                              ) 
                            ),
                          );
                     },
                  ),
                ),
                new Expanded (
                  flex: 2,
                  child: FlatButton (
                    textColor: Colors.red,
                    onPressed: () {
                      return Alert (
                        context: context, 
                        title: "Are you sure you want to delete this contact?", 
                        buttons: [DialogButton(child: Text("Yes"), onPressed: () {
                          deleteContact(id);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Contacts()));
                        },), DialogButton(child: Text("No"), onPressed: () {
                          Navigator.pop(context);
                        },)]).show();
                    },
                    child: Text ('Delete')
                    )
                  )
              ]
            )
          )
      ); 
  }
}