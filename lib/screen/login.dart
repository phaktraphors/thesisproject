import 'dart:convert';

import 'package:kate_botique_app/models/product.dart';
import 'package:kate_botique_app/models/user.dart';
import 'package:kate_botique_app/screen/checkout_screen.dart';
import 'package:kate_botique_app/screen/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:kate_botique_app/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  final List<Product> cartItems;
  Login({this.cartItems});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final email = TextEditingController();
  final password = TextEditingController();

  _login(BuildContext context, User user) async {
    var _userService = UserService();
    var registeredUser = await _userService.login(user);
    var result = json.decode(registeredUser.body);
    
    if(result['result'] == true){
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      print(result['user']['id']);
      _prefs.setInt('userId', result['user']['id']);
      _prefs.setString('userName', result['user']['name']);
      _prefs.setString('userEmail', result['user']['email']);
      print(_prefs.getInt('userId'));
      Navigator.push(
            context, MaterialPageRoute(builder: (context) => CheckoutScreen(cartItems: this.widget.cartItems,)));
    } else {
      _showSnackMessage(Text('Failed to login!', style: TextStyle(color: Colors.red),));
    }
  }

  _showSnackMessage(message){
    var snackBar = SnackBar(
      content: message,
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.red,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
         padding: const EdgeInsets.only(top: 20),
        child: ListView(
          children: <Widget>[
            Image.asset("images/logo.jpg",width: 200,height: 200,),
            Padding(
              padding: const EdgeInsets.only(
              left: 48.0, top: 14.0, right: 48.0, bottom: 14.0),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                  hintText: 'Email address',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 48.0, top: 14.0, right: 48.0, bottom: 14.0),
              child: TextField(
                controller: password,
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
              ),
            ),
            Column(
              children: <Widget>[
                ButtonTheme(
                  minWidth: 320,
                  height: 45.0,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    color: Colors.pink,
                    onPressed: () {
                      var user = User();
                      user.email = email.text;
                      user.password = password.text;
                      _login(context, user);
                    },
                    child: Text(
                      'LOGIN',
                      style: TextStyle(color: Colors.white),
                    ),

                  ),
                ),

                FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RegistrationScreen(cartItems: this.widget.cartItems,),),);
                  },
                  child: FittedBox(child: Text('Create Account'),),

                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}