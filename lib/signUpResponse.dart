
import 'package:flutter/material.dart';
import 'package:practice_app/databaseConnect.dart';
import 'package:practice_app/login.dart';
import 'package:practice_app/loginResponse.dart';
import 'package:practice_app/main.dart';
import 'package:practice_app/signUp.dart';
import 'package:practice_app/user.dart';
import 'package:practice_app/globals.dart' as globals;


class SignUpResponse extends StatelessWidget {
  final String username, password, email, f_name, l_name;

  const SignUpResponse({Key key, this.username, this.password, this.email, this.f_name, this.l_name}) : super(key: key);
  
  //var f_name;

  //print("globals.currentUser.isLoggedIn");
  // if (globals.currentUser != null) f_name = globals.currentUser.f_name;
  @override
  Widget build(BuildContext context) {
    return SignUpResp(username: username, password: password, email: email, f_name: f_name, l_name: l_name); 
  }
}



class SignUpResp extends StatelessWidget{
  final String username, password, email, f_name, l_name;

  const SignUpResp({Key key, this.username, this.password, this.email, this.f_name, this.l_name}) : super(key: key);




// first, create the user, then call login page  
  @override
  Widget build(BuildContext context) {
    print(username);
    //if (username == null || password == null || email == null) return SignUp(requiredError: true);
    createUser({'username': username, 'password': password, 'user_email': email, 'f_name': f_name, 'l_name': l_name});
    return LoginResponse(username, password);
    // FutureBuilder<User>(
    //   future: getUser(username, password),
    //   builder: (context, snapshot) {
    //     User user = snapshot.data;
    //     if (user == null)
    //       return Login(true);
    //       // Column(mainAxisAlignment: MainAxisAlignment.center,
    //       //           children: <Widget>[
    //       //             Text('incorrect username or password', 
    //       //             style: TextStyle(fontSize: 30), textAlign: TextAlign.center,
    //       //               ),
    //       //             ],
    //       //           );             
    //     String f_name = user.f_name;
    //     switch (snapshot.connectionState) {
    //       case ConnectionState.none:
    //         return Text("none");
    //       case ConnectionState.active:
    //         return Text("active");
    //       case ConnectionState.waiting:
    //         return Text("active and maybe waiting");
    //       case ConnectionState.done:
    //         return Scaffold(
    //   appBar: AppBar(title: Text("Home Page")),
    //   body: Center(
    //     child: Column(mainAxisAlignment: MainAxisAlignment.center,
    //                 children: <Widget>[
    //                   Text('Welcome to your virtual business card app, $f_name!', 
    //                   style: TextStyle(fontSize: 30), textAlign: TextAlign.center,
    //                     ),
    //                   ],
    //                 )
    //   ),
    //   drawer: MyDrawer()
    //       );
    //       default:
    //         return Text("done");
    //     }
    //   }
    // );
  }
}

// LoginResponse processLogin(String username, String password) {
//   Future<User> user =  getUser(username, password);
//   if (user == null) print("error");
  
//   else return LoginResponse(); 
// }