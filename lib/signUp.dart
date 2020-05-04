// UI from https://github.com/MarcusNg/flutter_login_ui/blob/master/lib/utilities/constants.dart

import 'package:flutter/material.dart';
import 'package:practice_app/loginResponse.dart';
import 'package:practice_app/main.dart';
import 'package:practice_app/signUpResponse.dart';

class SignUp extends StatefulWidget {
  final bool requiredError;
  final bool usernameError;


  const SignUp({Key key, this.requiredError, this.usernameError}) : super(key: key);
    

  @override
  _SignUpState createState() => _SignUpState(requiredError, usernameError);
}

class _SignUpState extends State<SignUp> {
  String username, password, email, f_name, l_name;
  final bool requiredError;
  final bool usernameError;

  _SignUpState(this.requiredError, this.usernameError);

    Widget _buildEmail() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email *',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            //fontFamily: 'OpenSans',
          )
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Color(0xFF4DD0E1),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
                ),
              ],
            ),
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (val) => email = val,
            style: TextStyle(
              color: Colors.white,
              //fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: TextStyle(
                color: Colors.white54,
                //fontFamily: 'OpenSans',
              ),
            ),  
          )
        )
      ],
      );
    }

Widget _buildUsername() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Username *',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            //fontFamily: 'OpenSans',
          )
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Color(0xFF4DD0E1),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
                ),
              ],
            ),
          height: 60.0,
          child: TextField(
            //keyboardType: TextInputType.emailAddress,
            onChanged: (val) => username = val,
            style: TextStyle(
              color: Colors.white,
              //fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: 'Pick a Username',
              hintStyle: TextStyle(
                color: Colors.white54,
                //fontFamily: 'OpenSans',
              ),
            ),  
          )
        )
      ],
      );
    }
    Widget _buildFirstName() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'First Name',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            //fontFamily: 'OpenSans',
          )
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Color(0xFF4DD0E1),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
                ),
              ],
            ),
          height: 60.0,
          child: TextField(
            //keyboardType: TextInputType.emailAddress,
            onChanged: (val) => f_name = val,
            style: TextStyle(
              color: Colors.white,
              //fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0, left: 30, bottom: 12),
              // prefixIcon: Icon(
              //   Icons.person,
              //   color: Colors.white,
              // ),
              hintText: 'Enter your First Name',
              hintStyle: TextStyle(
                color: Colors.white54,
                //fontFamily: 'OpenSans',
              ),
            ),  
          )
        )
      ],
      );
    }

  Widget _buildLastName() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Last Name',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            //fontFamily: 'OpenSans',
          )
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Color(0xFF4DD0E1),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
                ),
              ],
            ),
          height: 60.0,
          child: TextField(
            //keyboardType: TextInputType.emailAddress,
            onChanged: (val) => l_name = val,
            style: TextStyle(
              color: Colors.white,
              //fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0, left: 30, bottom: 12),
              // prefixIcon: Icon(
              //   Icons.person,
              //   color: Colors.white,
              // ),
              hintText: 'Enter your Last Name',
              hintStyle: TextStyle(
                color: Colors.white54,
                //fontFamily: 'OpenSans',
              ),
            ),  
          )
        )
      ],
      );
    }

    Widget _buildPassword() {
      return Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Color(0xFF4DD0E1),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6.0,
              offset: Offset(0, 2),
              ),
            ],
          ),
        height: 60.0,
        child: TextField(
          obscureText: true,
          onChanged: (val) => password = val,
          style: TextStyle(
            color: Colors.white,
            //fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.white,
            ),
            hintText: 'Enter your Password',
            hintStyle: TextStyle(
              color: Colors.white54,
              //fontFamily: 'OpenSans',
            ),
          ),  
        )
      );
    }

  Widget _buildSignUpBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpResponse(username: username, password: password, f_name: f_name, l_name: l_name))),
        },
        //processLogin(_username, _password),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'SIGN UP',
          style: TextStyle(
            color: Color(0xFF00BCD4),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

    Widget _buildRequirementError() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Enter all required fields',
          style: TextStyle(
            color: Colors.red[700],
            fontWeight: FontWeight.bold,
          ), textAlign: TextAlign.center,
        ),
        // SizedBox(height: 20.0),
        // Text(
        //   'Sign in with',
        //   style: TextStyle(
        //     color: Colors.white,
        //     fontWeight: FontWeight.bold
        //     //fontFamily: 'OpenSans',
        // ),
        // ),
      ],
    );
  }

Widget _buildUsernameError() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'That username is taken. Try another one!',
          style: TextStyle(
            color: Colors.red[700],
            fontWeight: FontWeight.bold,
          ), textAlign: TextAlign.center,
        ),
        // SizedBox(height: 20.0),
        // Text(
        //   'Sign in with',
        //   style: TextStyle(
        //     color: Colors.white,
        //     fontWeight: FontWeight.bold
        //     //fontFamily: 'OpenSans',
        // ),
        // ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   appBar: AppBar(
      //   title: Text("Login"),
      // ),
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration (
              gradient: LinearGradient (
                begin: Alignment.bottomCenter, 
                end: Alignment.topCenter, 
                colors: [
                  Color(0xFF00BCD4),
                  Color(0xFF26C6DA),
                  Color(0xFF4DD0E1),
                  Color(0xFF80DEEA),
                  ],
                stops: [0.1, 0.4, 0.7, 0.9],
                ),
              )
            ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 120.0,
                ),
                child: Column(children: <Widget>[
                if (requiredError == true) _buildRequirementError(),
                if (usernameError == true) _buildUsernameError(),
                SizedBox(height: 10),
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: 30.0, 
                      fontWeight: FontWeight.bold,
                     )
                  ),
                  SizedBox(height: 30,),
                  _buildEmail(),
                  SizedBox(height: 30,),
                  _buildFirstName(),
                  SizedBox(height: 30,),
                  _buildLastName(),
                  SizedBox(height: 30,),
                  _buildUsername(),
                  SizedBox(height: 30,),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Password *',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        //fontFamily: 'OpenSans',
                      )
                    ),
                    SizedBox(height: 10.0),
                    _buildPassword(),
                    _buildSignUpBtn(),
                  ],
                  )
                ],)
              ),
            )
        ],),
      drawer: MyDrawer(),
    );
  }
}


