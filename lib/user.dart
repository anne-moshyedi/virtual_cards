import 'package:flutter/material.dart';


class User extends StatelessWidget{
  String username;
  String _password;

  User(this.username, this._password);

  User.fromMap(dynamic obj) {
    this.username = obj['username'];
    this._password = obj['password'];
  }
  //String get username => username;
  String get password => _password;
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = username;
    map["password"] = _password;
    return map;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
