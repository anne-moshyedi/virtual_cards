import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:practice_app/contacts.dart';
import 'package:practice_app/login.dart';
import 'package:practice_app/profile.dart';
import 'package:practice_app/search.dart';
import 'package:practice_app/events.dart';
import 'package:practice_app/notes.dart';
import 'package:practice_app/settings.dart';
import 'package:sqflite/sqflite.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
  final database = openDatabase(join('/Users/anniemoshyedi/Desktop/practice_app/lib/', 'practice_app_data.db'), version: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Welcome to your virtual business card app!'),
            FlatButton (
              child: Text("click to login"), 
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
              }
              )
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
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: ListTile(
                title:Text('Virtual Cards',
                style: TextStyle(
                color: Colors.white,
                fontSize: 24

                )
              ),
              onTap: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              }
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

