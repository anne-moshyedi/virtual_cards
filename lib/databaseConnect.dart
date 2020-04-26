import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:practice_app/businessCard.dart';
import 'package:practice_app/main.dart';
import 'package:sqflite/sqflite.dart';
import 'package:practice_app/user.dart';
import 'package:practice_app/globals.dart' as globals;

class DatabaseConnect {
 final database = openDatabase(join('/Users/anniemoshyedi/Desktop/practice_app/lib/', 'practice_app_data.db'), version: 1);
}

Future<User> getUser(String user, String password) async {
  final database = openDatabase(join('/Users/anniemoshyedi/Desktop/practice_app/lib/', 'practice_app_data.db'), version: 1);
  // Get a reference to the database.
  final db = await database;
  var res = await db.rawQuery("SELECT * FROM user WHERE username = '$user' and password = '$password'");
  if (res.length > 0) {
    // if the user exists, create a user, and make the rest of the contact personalized for that user
    
    globals.isLoggedIn = true;
    globals.currentUser = User.fromMap(res.first);
    print("creating user global");
    //call login response and go to a welcome page or something 
    //return;
    return new User.fromMap(res.first);
  }
  return;
}

Future<List<BCard>> getInfo(personal, [String searchQuery]) async {
    if (globals.isLoggedIn == false || globals.currentUser == null) return null;
    var username = globals.currentUser.username;
    final database = openDatabase(join('/Users/anniemoshyedi/Desktop/practice_app/lib/', 'practice_app_data.db'), version: 1);
    final Database myDB = await database;
    final allRows = await myDB.rawQuery('SELECT * FROM business_card b JOIN user_has_cards u ON b.card_id = u.id WHERE (f_name LIKE "%$searchQuery%" OR l_name LIKE "%$searchQuery%" OR mobile_number LIKE "%$searchQuery%"  OR email_addr LIKE "%$searchQuery%" OR street_addr LIKE "%$searchQuery%" OR notes LIKE "%$searchQuery%" OR title LIKE "%$searchQuery%" OR company LIKE "%$searchQuery%") AND (card_id IN (SELECT id FROM user_has_cards WHERE username = "$username" AND personal = $personal)) AND username = "$username" ORDER BY f_name, l_name');
    //print('SELECT * FROM business_card b JOIN user_has_cards u ON b.card_id = u.id WHERE (f_name LIKE "%$searchQuery%" OR l_name LIKE "%$searchQuery%" OR mobile_number LIKE "%$searchQuery%"  OR email_addr LIKE "%$searchQuery%" OR street_addr LIKE "%$searchQuery%" OR notes LIKE "%$searchQuery%" OR title LIKE "%$searchQuery%" OR company LIKE "%$searchQuery%") AND (card_id IN (SELECT card_id FROM user_has_cards WHERE username = "$username" AND personal = $personal)) AND username = "$username" ORDER BY f_name, l_name');
    return List.generate(allRows.length, (i) {
      BCard a = new BCard(allRows[i]['card_id'], allRows[i]['f_name'], allRows[i]['l_name'],
        allRows[i]['mobile_number'],
        allRows[i]['email_addr'], allRows[i]['street_addr'],
        allRows[i]['website'], allRows[i]['linked_in'], 
        allRows[i]['personal'], allRows[i]['notes'],
        allRows[i]['title'], allRows[i]['company']);
        //print(a);
      return (a);
    });
  }



Future<void> deleteContact(String id) async {
 if (globals.isLoggedIn == false || globals.currentUser == null) return null;

 final database = openDatabase(join('/Users/anniemoshyedi/Desktop/practice_app/lib/', 'practice_app_data.db'), version: 1);

  // Get a reference to the database.
  final db = await database;

  // Remove the contact from the Database.
  await db.delete(
    'business_card',
    // Use a `where` clause to delete a specific dog.
    where: "card_id = ?",
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs: [id],
  );
}

Future<void> updateNotes(String notes, String id) async {
  if (globals.isLoggedIn == false || globals.currentUser == null) return null;
  // Get a reference to the database.
  final database = openDatabase(join('/Users/anniemoshyedi/Desktop/practice_app/lib/', 'practice_app_data.db'), version: 1);

  var username = globals.currentUser.username;
  final db = await database;
  print(notes);
  // Update the given Dog.
  await db.update(
    'user_has_cards',
    {'notes': '$notes'},
    // Ensure that the Dog has a matching id.
    where: "id = ? AND username = ?",
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs: [id, username],
  );
}

// now, on the login, go to the main page and pass the user

