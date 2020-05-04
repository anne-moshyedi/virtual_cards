import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:practice_app/businessCard.dart';
import 'package:practice_app/main.dart';
import 'package:practice_app/signUp.dart';
import 'package:sqflite/sqflite.dart';
import 'package:practice_app/user.dart';
import 'package:practice_app/globals.dart' as globals;

class DatabaseConnect {
 //final database = openDatabase(join('/Users/anniemoshyedi/Desktop/practice_app/lib/', 'practice_app_data.db'), version: 1);
}


Future<Database> getDatabase() async {
  // var path = await getDatabasesPath();
  //print(path);
  var path = '/Users/anniemoshyedi/Desktop/practice_app/lib/';
  final database = openDatabase(join(path, 'practice_app_data.db'), version: 1);
  return database;
}

Future<User> getUser(String user, String password) async {
  final database = getDatabase();
  //final database = openDatabase(join('/Users/anniemoshyedi/Desktop/practice_app/lib/', 'practice_app_data.db'), version: 1);
  // Get a reference to the database.
  final db = await database;
  var res = await db.rawQuery("SELECT * FROM user WHERE username = '$user' and password = '$password'");
  if (res.length > 0) {
    // if the user exists, create a user, and make the rest of the contact personalized for that user
    
    globals.isLoggedIn = true;
    globals.currentUser = User.fromMap(res.first);
    //print("creating user global");
    //call login response and go to a welcome page or something 
    //return;
    return new User.fromMap(res.first);
  }
  return new User.fromMap(res.first);
}

Future<List<BCard>> getInfo(personal, [String searchQuery]) async {
    if (globals.isLoggedIn == false || globals.currentUser == null) return null;
    var username = globals.currentUser.username;
    //final database = openDatabase(join('/Users/anniemoshyedi/Desktop/practice_app/lib/', 'practice_app_data.db'), version: 1);
    final database = getDatabase();
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
var username = globals.currentUser.username;
 //final database = openDatabase(join('/Users/anniemoshyedi/Desktop/practice_app/lib/', 'practice_app_data.db'), version: 1);
  final database = getDatabase();
  // Get a reference to the database.
  final db = await database;

  // Remove the contact from the Database.
  await db.delete(
    'user_has_cards',
    // Use a `where` clause to delete a specific dog.
    where: "id = ? AND username = ?",
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs: [id, username],
  );
}

Future<void> updateNotes(String notes, String id) async {
  if (globals.isLoggedIn == false || globals.currentUser == null) return null;
  // Get a reference to the database.
  //final database = openDatabase(join('/Users/anniemoshyedi/Desktop/practice_app/lib/', 'practice_app_data.db'), version: 1);
  final database = getDatabase();

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

Future<void> update(String updatedInfo, String field, String id) async {
  if (globals.isLoggedIn == false || globals.currentUser == null) return null;
  // Get a reference to the database.
  //final database = openDatabase(join('/Users/anniemoshyedi/Desktop/practice_app/lib/', 'practice_app_data.db'), version: 1);
  final database = getDatabase();
  var attribute;
  switch (field) {
    case "f_name":
      attribute = "l_name";
      break;
    case "l_name":
      attribute = "l_name";
      break;
    case "Title":
      attribute = "title";
      break;
    case "Company":
      attribute = "company";
      break;
    case "Mobile":
      attribute = "mobile_number";
      break;
    case "Email":
      attribute = "email_addr";
      break;
    case "Address":
      attribute = "street_addr";
      break;
    case "LinkedIn":
      attribute = "linked_in";
      break;
    case "Website":
      attribute = "website";
      break;
    default:
      break;
  }
  //var username = globals.currentUser.username;
  final db = await database;
  //print(notes);
  // Update the given Dog.
  await db.update(
    'business_card',
    {'$attribute': '$updatedInfo'},
    // Ensure that the Dog has a matching id.
    where: "card_id = ?",
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs: [id],
  );
}

// now, on the login, go to the main page and pass the user

Future<void> createCard(Map<String, String> contactInfo) async{
  print("good in createCard");
  final database = await getDatabase();
  var recentCardId = await database.rawQuery('SELECT recent_id FROM global');
  int newCardId = (recentCardId[0]["recent_id"] + 1);
  String cardId = newCardId.toString();
  await database.update('global', {'recent_id': newCardId});
  contactInfo.remove("");
  contactInfo["card_id"] = cardId;
  print(contactInfo);
  database.insert('business_card', contactInfo);
  // update user_has_cards table
  String username = globals.currentUser.username;
  database.insert('user_has_cards', {'username': username, 'id': cardId, 'personal': 1});
}

Future<void> createUser(Map<String, String> userInfo) async{
  final database = await getDatabase();
  try{
  database.insert('user', userInfo);
  }
  catch (error) {
    SignUp(usernameError: true);
  }
}