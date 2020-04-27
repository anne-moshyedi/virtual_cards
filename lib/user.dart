import 'package:flutter/material.dart';


class User extends StatelessWidget{
  String username;
  String _password;
  String f_name;
  String l_name;
  String email;

  User(this.username, this._password, this.f_name, this.l_name, this.email);

  User.fromMap(dynamic obj) {
    this.username = obj['username'];
    this._password = obj['password'];
    this.f_name = obj['f_name'];
    this.l_name = obj['l_name'];
    this.email = obj['user_email'];
  }
  //String get username => username;
  String get password => _password;
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = username;
    map["password"] = _password;
    map["f_name"] = f_name;
    map["l_name"] = l_name;
    map["user_email"] = email;
    return map;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
