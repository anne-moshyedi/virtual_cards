import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:practice_app/contactExpanded.dart';

// class BusinessCard {
//   static final _databaseName = "practice_app_data.db";
//   static final _databaseVersion = 1;

//   static final table = 'business_card';
//   static final cardId = 'cardId';
//   static final fName = 'fName';
//   static final lName = 'lName';
//   static final mobileNumber = 'mobileNumber';
//   static final emailAddr = 'emailAddr';
//   static final streetAddr = 'streetAddr';
//   static final website = 'website';
//   static final linkedIn = 'linkedIn';
//   static final personal = 'personal';
//   static final notes = 'notes'; 

//   BusinessCard._privateConstructor();
//   static final BusinessCard instance = BusinessCard._privateConstructor();
//   static Database _db;

//   Future<Database> get db async {
//     print(_db);
//     if (_db != null) return _db;
//     // lazily instantiate the db the first time it is accessed
//     print('this is where i want it');
//     _db = await _initDatabase();
//     return _db;
//   }
//     _initDatabase() async {
//     var documentsDirectory = await getDatabasesPath();
//     print(documentsDirectory);
//    // Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join('/Users/anniemoshyedi/Desktop/practice_app/lib/', _databaseName);
//     return await openDatabase(path,
//         version: _databaseVersion,
//         //onCreate: _onCreate
//         );
//     }
//   //   Future _onCreate(Database db, int version) async {
//   //   await db.execute('''
//   //         CREATE TABLE $table (
//   //           $cardId STRING PRIMARY KEY,
//   //           $fName STRING,
//   //           $lName STRING
//   //         )
//   //         ''');
//   // }
//     Future<List<Map<String, dynamic>>> queryAllRows() async {
//     Database db = await instance.db;
//     //print(db.query(table));
//     return await db.query(table);
//   }
//   Future<dynamic> queryFirstRow() async {
//     Database db = await instance.db;
//     //print(db.rawQuery('''SELECT * FROM business_card'''));
//     Future<dynamic> firstItem = (db.rawQuery("SELECT * FROM business_card WHERE card_id = '1234'"));
//     //print(firstItem);
//     return firstItem;
//   }
//     Future<int> queryRowCount() async {
//     Database db = await instance.db;
//     return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
//   }
// }

class BCard extends StatelessWidget{
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
  final String title;
  final String company;

  BCard(this.card_id, this.f_name, this.l_name, this.mobile_number, this.email_addr, this.street_addr, this.website, this.linked_in, this.personal, this.notes, this.title, this.company);

  Map<String, dynamic> toMap() {
    return {
      'card_id': card_id,
      'f_name': f_name,
      'l_name': l_name,
      'mobile_number': mobile_number,
      'email_addr': email_addr,
      'street_addr': street_addr,
      'website': website,
      'linked_in': linked_in,
      'personal': personal,
      'notes': notes,
      'title': title,
      'company': company
    };
  }
  // @override
  // String toString() {
  //   return 'BCard{card_id: $card_id, f_name: $f_name, l_name: $l_name, mobile_number: $mobile_number, email_addr: $email_addr, street_addr: $street_addr, website: $website, linked_in: $linked_in, personal: $personal, notes: $notes}';
  // }

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
          ["Name", '$f_name $l_name', 
          "Title", "$title", 
          "Company", "$company", 
          "Mobile", '$mobile_number', 
          "Email", "$email_addr", 
          "Address", "$street_addr", 
          "LinkedIn", "$linked_in",
          "Website", "$website",
          "Notes", "$notes"], id: card_id, names: ['First Name', '$f_name', 'Last Name', '$l_name'], personal: personal)),//List<String>.generate(10, (i) => "Item $i"),)),
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
                  '$f_name $l_name',
                  style: Theme.of(context).textTheme.headline,
                ),
                Text(
                  '$title',
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
            // mailto and tel don't work on simulator. need to run on physical device.
            IconButton(
              icon: Icon(Icons.email),
              onPressed: () {_launchUrl('mailto:$email_addr');},
            ),
            IconButton(
              icon: Icon(Icons.local_phone),
              onPressed: () {_launchUrl('tel:$mobile_number');},
            ),
            IconButton(
              icon: Icon(Icons.device_hub),
              onPressed: () {_launchUrl('$linked_in');},
            ),
            IconButton(
              icon: Icon(Icons.public),
              onPressed: () {_launchUrl('$website');},
            ),
          ],
        ),
      ],
      ),
    );
  }
}
