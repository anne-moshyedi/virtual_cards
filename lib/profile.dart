import 'package:flutter/material.dart';
import 'package:practice_app/contactExpanded.dart';
import 'package:practice_app/main.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: new ListView.separated(
        padding: const EdgeInsets.all(2),
        itemCount: 2,
        itemBuilder: (BuildContext context, int index)
        { return ContactCard(); },
        separatorBuilder: (BuildContext context, int index) =>const Divider() ),
        drawer: MyDrawer(),
        );
  //      if I want to use .builder, take out padding and separatorBuilder
  }
}


class ContactCard extends StatelessWidget {
  
  final String card_id;
  final String f_name;
  final String l_name;
  final String mobile_number;
  final String email_addr;
  final String street_addr;
  final String website;
  final String linked_in;
  final String personal;
  final String notes;

  const ContactCard({Key key, this.card_id, this.f_name, this.l_name, this.mobile_number, this.email_addr, this.street_addr, this.website, this.linked_in, this.personal, this.notes}) : super(key: key);

    void _launchUrl(String url) async{
    if(await canLaunch(url)){
      await launch(url);
    }
    else{
      throw 'Could not open URL';
    }
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      // When the user taps a contact, take them to the full contact page.
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ContactExpanded(contactInfo: 
          ["Name", "Annie Moshyedi", "Mobile", "(301) 529-6024", "Email", "acm4xb@virginia.edu", 
          "Address", "418 17th Street NW, Charlottesville, VA, 22903", 
          "LinkedIn", "https://www.linkedin.com/in/anne-moshyedi/",
          "Website", "https://anne-moshyedi.github.io/",
          "Notes", "Met Annie at UVA career fair."] )),//List<String>.generate(10, (i) => "Item $i"),)),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.account_circle, size: 50),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Annie Moshyedi',
                  style: Theme.of(context).textTheme.headline,
                ),
                Text(
                  'Software Engineer',
                )
              ],
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // mailto and tell don't work on simulator. need to run on physical device.
            IconButton(
              icon: Icon(Icons.email),
              onPressed: () {_launchUrl('mailto:annemoshyedi@gmail.com');},
            ),
            IconButton(
              icon: Icon(Icons.local_phone),
              onPressed: () {_launchUrl('tel:+1 301 529 6024');},
            ),
            IconButton(
              icon: Icon(Icons.device_hub),
              onPressed: () {_launchUrl('https://www.linkedin.com/in/anne-moshyedi/');},
            ),
            IconButton(
              icon: Icon(Icons.public),
              onPressed: () {_launchUrl('https://anne-moshyedi.github.io/');},
            ),
          ],
        ),
      ],
      ),
    );
  }
}


