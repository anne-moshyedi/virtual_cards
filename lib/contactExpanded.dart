import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ContactExpanded extends StatelessWidget {
  final List<String> contactInfo;

  const ContactExpanded({Key key, this.contactInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int len = (contactInfo.length/2).floor();
    return Scaffold(
        appBar: AppBar(
          title: Text("Annie Moshyedi"),
        ),
        body: new ListView.builder(
          padding: const EdgeInsets.all(2),
          itemCount: len,
          itemBuilder: (BuildContext context, int index)
            { 
              final field = contactInfo[index*2];
              final info = contactInfo[index*2+1];
              return ListTile(
              title: Text('$field'),
              subtitle: Text('$info'),
            );
            },
        ),
      ); 
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

