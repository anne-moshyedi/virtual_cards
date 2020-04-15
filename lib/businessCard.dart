import 'dart:io';

import 'package:path/path.dart';
import 'package:practice_app/profile.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';


  

class BusinessCard {

  static final _databaseName = "practice_app_data.db";
  static final _databaseVersion = 1;

  static final table = 'business_card';

  static final cardId = 'cardId';
  static final fName = 'fName';
  static final lName = 'lName';
  static final mobileNumber = 'mobileNumber';
  static final emailAddr = 'emailAddr';
  static final streetAddr = 'streetAddr';
  static final website = 'website';
  static final linkedIn = 'linkedIn';
  static final personal = 'personal';
  static final notes = 'notes'; 

  BusinessCard._privateConstructor();
  static final BusinessCard instance = BusinessCard._privateConstructor();
  
  
  static Database _db;
  Future<Database> get db async {
    print(_db);
    if (_db != null) return _db;
    // lazily instantiate the db the first time it is accessed
    print('this is where i want it');
    _db = await _initDatabase();
    return _db;
  }
    
    _initDatabase() async {
    var documentsDirectory = await getDatabasesPath();
    print(documentsDirectory);
   // Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join('/Users/anniemoshyedi/Desktop/practice_app/lib/', _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        //onCreate: _onCreate
        );
    }

    Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $cardId STRING PRIMARY KEY,
            $fName STRING,
            $lName STRING
          )
          ''');
  }

    Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.db;
    //print(db.query(table));
    return await db.query(table);
  }

  Future<dynamic> queryFirstRow() async {
    Database db = await instance.db;
    //print(db.rawQuery('''SELECT * FROM business_card'''));
    Future<dynamic> firstItem = (db.rawQuery("SELECT * FROM business_card WHERE card_id = '1234'"));
    //print(firstItem);
    return firstItem;
  }

  // String queryFirstRow1() {
  //   String returnItem = queryFirstRow1().toString();
  //   //print("PRINTING RETURNITEM");
  //   print(returnItem);
  //   return returnItem;
  // }


  //   Future<List<String>> _getData(map) async {
  //   var values = new List<String>();
  //   //now i want to convert the future list map to a future list
  

  //   await new Future.delayed(new Duration(seconds: 5));


  //   return values;
  // }


    Future<int> queryRowCount() async {
    Database db = await instance.db;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

}



  // void readDB() async {

  //   final database = openDatabase(
  //   // Set the path to the database. Note: Using the `join` function from the
  //   // `path` package is best practice to ensure the path is correctly
  //   // constructed for each platform.
  //   join('/Users/anniemoshyedi/Desktop/practice_app/lib/', 'practice_app_data.db'),
  //   // When the database is first created, create a table to store dogs.
  //   onCreate: (db, version) {
  //     return db.execute(
  //       "CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
  //     );
  //   },
  //   // Set the version. This executes the onCreate function and provides a
  //   // path to perform database upgrades and downgrades.
  //   version: 1,
  // );
  //   Future<List<BusinessCard>> cards() async {
  //     final Database db = await database;
  //     final List<Map<String, dynamic>> maps = await db.query('business_cards');
  //     return List.generate(maps.length, (i) {
  //       return BCard(
  //         card_id: maps[i]['card_id'],
  //         f_name: maps[i]['card_id'],
  //         l_name: maps[i]['card_id'],
  //         mobile_number: maps[i]['card_id'],
  //         email_addr: maps[i]['card_id'],
  //         street_addr: maps[i]['card_id'],
  //         website: maps[i]['card_id'],
  //         linked_in: maps[i]['card_id'],
  //         personal: maps[i]['card_id'],
  //         notes:  maps[i]['card_id'],
  //       );
  //   });
  //  }
  // }



class BCard {
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

  BCard(this.card_id, this.f_name, this.l_name, this.mobile_number, this.email_addr, this.street_addr, this.website, this.linked_in, this.personal, this.notes);

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
    };
  }
  @override
  String toString() {
    return 'BCard{card_id: $card_id, f_name: $f_name, l_name: $l_name, mobile_number: $mobile_number, email_addr: $email_addr, street_addr: $street_addr, website: $website, linked_in: $linked_in, personal: $personal, notes: $notes}';
  }
}
