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
    return await db.query(table);
  }

    Future<int> queryRowCount() async {
    Database db = await instance.db;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }
}


  // void readDB() async {


  //   final Future<Database> database = openDatabase(join(await getDatabasesPath(), 'practice_app_data.db'),);
    
  //   Future<List<BusinessCard>> cards() async {
  //     final Database db = await database;
  //     final List<Map<String, dynamic>> maps = await db.query('business_cards');
  //     return List.generate(maps.length, (i) {
  //       return BusinessCard(
  //         cardId: maps[i]['card_id'],
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
  //     };
  //   }
  // }

