import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:path/path.dart';
import 'package:practice_app/businessCard.dart';
import 'package:practice_app/contacts.dart';
import 'package:practice_app/profile.dart';
import 'package:practice_app/search.dart';
import 'package:practice_app/events.dart';
import 'package:practice_app/notes.dart';
import 'package:practice_app/settings.dart';
import 'package:sqflite/sqflite.dart';


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

  final myDB = BusinessCard.instance;

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
            RaisedButton(
              child: Text('query', style: TextStyle(fontSize: 20),),
              onPressed: () {_query();},
            ),
          ],
        ),
      ),
      drawer: MyDrawer()
    );
  }
  Future<List<BCard>> _query() async {
    final Database myDB = await database;
    final allRows = await myDB.query('business_card');
    //print("printing all rows:");
    //print(allRows.length);
    return List.generate(allRows.length, (i) {
      // my issue is that for some reason card_id and mobile_number is an int
      // var v = allRows[i]['mobile_number'];
      // print(v);
      // if (v is String ) print("String");
      BCard a = new BCard(allRows[i]['card_id'], allRows[i]['f_name'], allRows[i]['l_name'],
        allRows[i]['mobile_number'],
        allRows[i]['email_addr'], allRows[i]['street_addr'],
        allRows[i]['website'], allRows[i]['linked_in'], 
        allRows[i]['personal'], allRows[i]['notes'], );
      //print(a.personal);
      return (a);
    });
  }
}



  // this method below was almost working, but list.generate isnt working
  // Future<List<BCard>> _query() async {
  //   final myDB = BusinessCard.instance;
  //   final allRows = await myDB.queryAllRows();
  //   return List.generate(allRows.length, (i) {
  //     BCard a = new BCard(allRows.first['card_id'], allRows.first['f_name'], allRows.first['l_name'],
  //      allRows.first['mobile_number'], allRows.first['email_addr'], allRows.first['street_addr'],
  //       allRows.first['website'], allRows.first['linked_in'], allRows.first['personal'], allRows.first['notes']);
  //     return (a);
  //   });
  //   print('query all rows:');
  //   allRows.forEach((row) => print(row));
  //   print("PRINT QUERYFIRSTROW");
  //   final firstRow = (await myDB.queryFirstRow());
  //   Map<String, dynamic> map = firstRow.first;
  //   print(map);
  //   print(map['card_id']);
  // }


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

