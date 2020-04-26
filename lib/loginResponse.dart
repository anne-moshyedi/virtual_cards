
import 'package:flutter/material.dart';
import 'package:practice_app/databaseConnect.dart';
import 'package:practice_app/login.dart';
import 'package:practice_app/main.dart';
import 'package:practice_app/user.dart';
import 'package:practice_app/globals.dart' as globals;


class LoginResponse extends StatelessWidget {
  final String username;
  final String password;
  
  //var f_name;

  const LoginResponse(this.username, this.password);
  //print("globals.currentUser.isLoggedIn");
  // if (globals.currentUser != null) f_name = globals.currentUser.f_name;
  @override
  Widget build(BuildContext context) {
    return LoginResp(username, password); 
  }
}

// class LoginResponse extends StatelessWidget {
  
//   var f_name;
//   //print("globals.currentUser.isLoggedIn");
//   // if (globals.currentUser != null) f_name = globals.currentUser.f_name;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Welcome!")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text('Welcome to your virtual business card app!', 
//             style: TextStyle(fontSize: 30), textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//       drawer: MyDrawer()
//     );
//   }
// }


class LoginResp extends StatelessWidget{
  final String username;
  final String password;

  const LoginResp(this.username, this.password);


// somehow in here, register if there is no user, and return something else... maybe ConnectionState.done & snapshot.username or something is null
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: getUser(username, password),
      builder: (context, snapshot) {
        User user = snapshot.data;
        if (user == null)
          return Login(true);
          // Column(mainAxisAlignment: MainAxisAlignment.center,
          //           children: <Widget>[
          //             Text('incorrect username or password', 
          //             style: TextStyle(fontSize: 30), textAlign: TextAlign.center,
          //               ),
          //             ],
          //           );             
        String f_name = user.f_name;
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text("none");
          case ConnectionState.active:
            return Text("active");
          case ConnectionState.waiting:
            return Text("active and maybe waiting");
          case ConnectionState.done:
            return Scaffold(
      appBar: AppBar(title: Text("Welcome!")),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Welcome to your virtual business card app, $f_name!', 
                      style: TextStyle(fontSize: 30), textAlign: TextAlign.center,
                        ),
                      ],
                    )
      ),
      drawer: MyDrawer()
          );
          default:
            return Text("done");
        }
      }
    );
  }
}

// LoginResponse processLogin(String username, String password) {
//   Future<User> user =  getUser(username, password);
//   if (user == null) print("error");
  
//   else return LoginResponse(); 
// }