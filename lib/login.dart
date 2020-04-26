// UI from https://github.com/MarcusNg/flutter_login_ui/blob/master/lib/utilities/constants.dart

import 'package:flutter/material.dart';
import 'package:practice_app/loginResponse.dart';
import 'package:practice_app/main.dart';
import 'package:practice_app/databaseConnect.dart';

class Login extends StatefulWidget {
  final bool error;

  const Login(this.error);
  

  @override
  _LoginState createState() => _LoginState(error);
}

class _LoginState extends State<Login> {
  String _username, _password;
  bool _rememberMe = false;

  final bool error;

  _LoginState(this.error);

    Widget _buildEmail() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Username',
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
            onChanged: (val) => _username = val,
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
              hintText: 'Enter your Username',
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
          onChanged: (val) => _password = val,
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

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            color: Colors.white,
            //fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: TextStyle(
            color: Colors.white,
            //fontFamily: 'OpenSans',
          ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginResponse(_username, _password))),
              },
        //processLogin(_username, _password),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
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

  Widget _buildSignInWith() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Sign in with',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
            //fontFamily: 'OpenSans',
          ),
        ),
      ],
    );
  }


  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

    Widget _buildErrorMsg() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Incorrect username or password',
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

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
            () => print('Login with Facebook'),
            AssetImage(
              'assets/logos/facebook.jpg',
            ),
          ),
          _buildSocialBtn(
            () => print('Login with Google'),
            AssetImage(
              'assets/logos/google.jpg',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => print('Sign Up Button Pressed'),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
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
                if (error == true) _buildErrorMsg(),
                SizedBox(height: 10),
                  Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: 30.0, 
                      fontWeight: FontWeight.bold,
                     )
                  ),
                  SizedBox(height: 30,),
                  _buildEmail(),
                  SizedBox(height: 30,),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        //fontFamily: 'OpenSans',
                      )
                    ),
                    SizedBox(height: 10.0),
                    _buildPassword(),
                    _buildForgotPasswordBtn(),
                    _buildRememberMeCheckbox(),
                    _buildLoginBtn(),
                    // implement these later on
                    // _buildSignInWith(),
                    // _buildSocialBtnRow(),
                    // _buildSignupBtn(),
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


