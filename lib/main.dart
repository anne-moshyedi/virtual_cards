import 'package:flutter/material.dart';
import 'package:practice_app/contacts.dart';
import 'package:practice_app/profile.dart';
import 'package:practice_app/search.dart';
import 'package:practice_app/events.dart';
import 'package:practice_app/notes.dart';
import 'package:practice_app/settings.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Virtual Cards',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        accentColor: Colors.cyan[100],
      ),
      home: MyHomePage(title: 'Virtual Cards'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Drawer drawer = const Drawer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Welcome to your virtual business card app!')
          ],
        ),
      ),
      drawer: MyDrawer()
    );
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              
              child: Text('Virtual Cards',
                style: TextStyle(
                color: Colors.white,
                fontSize: 24
                )
              ),
              decoration: BoxDecoration(
                color: Colors.cyan,
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
                // Update the state of the app
                // ...
                // Then close the drawer
                // Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text('Contact Cards'),
              onTap: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Contacts()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.event),
              title: Text('Events'),
              onTap: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Events()),
                );
              },
            ),
              ListTile(
              leading: Icon(Icons.keyboard),
              title: Text('Notes'),
              onTap: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Notes()),
                );
              },
            ),
              ListTile(
              leading: Icon(Icons.search),
              title: Text('Search'),
              onTap: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Search()),
                );
              },
            ),
              ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Settings()),
                );
              },
            ),
          ],
        ),
      );
  }
}

