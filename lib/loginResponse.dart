
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:practice_app/databaseConnect.dart';
import 'package:practice_app/main.dart';
import 'package:practice_app/user.dart';

class LoginResponse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome!")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Welcome to your virtual business card app!'),
            // FlatButton (
            //   child: Text("click to login"), 
            //   onPressed: () {
            //     Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
            //   }
            //   )
          ],
        ),
      ),
      drawer: MyDrawer()
    );
  }
}

LoginResponse processLogin(String username, String password) {
  Future<User> user = getUser(username, password);
  if (user == null) print("error");
  
  else return LoginResponse(); 
}