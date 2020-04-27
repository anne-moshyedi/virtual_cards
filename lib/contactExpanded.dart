import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:practice_app/contacts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:practice_app/databaseConnect.dart';
import 'package:practice_app/contactExpandedEditable.dart';


class ContactExpanded extends StatelessWidget {
  final List<String> contactInfo;
  final String id;
  final List<String> names;
  final String personal;

  //const ContactExpanded(this.contactInfo, this.id);

  const ContactExpanded({Key key, this.contactInfo, this.id, this.names, this.personal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int len = (contactInfo.length/2).floor();
    bool editable;
    if (personal == '1') editable = true;
    else editable = false;
    return Scaffold(
        appBar: AppBar(
          title: Text(contactInfo[1]),
          actions: [
            Visibility(
              visible: editable,
              child:
          IconButton(
            //child: Text("Edit"), 
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ContactExpandedEditable(contactInfo, id, names)));
            },
          ),
            )
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
                      if (field == 'Mobile') {
                        return ListTile (
                          title: Text('$field'),
                          subtitle: Text('$info'),
                          trailing: Wrap (
                            children: <Widget> 
                            [IconButton(
                            icon: Icon(Icons.sms),
                            color: Colors.cyan,
                            onPressed: () {_launchUrl('sms:$info');
                            },
                          ),
                            IconButton(
                            icon: Icon(Icons.local_phone),
                            color: Colors.cyan,
                            onPressed: () {_launchUrl('tel:$info');
                            },
                            )
                            ]
                          )
                        );
                      }
                      if (field == 'Email') {
                        return ListTile (
                          title: Text('$field'),
                          subtitle: Text('$info'),
                          trailing: IconButton(
                            icon: Icon(Icons.mail),
                            color: Colors.cyan,
                            onPressed: () {_launchUrl('mailto:$info');},
                            ),
                        );
                      }
                      if (field == 'Address') {
                        String urlAddr = info.replaceAll(new RegExp(r'[!,.\s]+'),'+');
                        return ListTile (
                          title: Text('$field'),
                          subtitle: Text('$info'),
                          trailing: IconButton (
                            icon: Icon(Icons.directions), 
                            color: Colors.cyan, 
                            onPressed: () {_launchUrl('http://maps.apple.com/?q=$urlAddr');
                          },
                          )
                        );
                      }
                      if (field == 'LinkedIn' || field == 'Website') {
                        var icon;
                        if (field == 'LinkedIn') icon = Icons.device_hub;
                        else icon = Icons.public;
                        return ListTile (
                          title: Text('$field'),
                          subtitle: Text('$info'),
                          trailing: IconButton(
                            icon: Icon(icon, color: Colors.cyan),
                            onPressed: () {_launchUrl('$info');
                            },
                          )
                        );
                      }
                      return ListTile(
                        title: Text('$field'),
                        subtitle: Text('$info'),
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

  void _launchUrl(String url) async{
    if(await canLaunch(url)){
      await launch(url);
    }
    else{
      throw 'Could not open URL';
    }
  }
}

/// The base class for the different types of items the list can contain.
abstract class ListItem {
  // /// The title line to show in a list item.
  // Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);
}

class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);

  Widget buildTitle(BuildContext context) => Text(sender);

  Widget buildSubtitle(BuildContext context) => Text(body);
}

