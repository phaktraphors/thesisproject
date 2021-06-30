import 'dart:convert';
import 'package:kate_botique_app/models/product.dart';
import 'package:kate_botique_app/models/user.dart';
import 'package:kate_botique_app/screen/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:kate_botique_app/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatefulWidget {
  final List<Product> cartItems;
  final _formKey = GlobalKey<FormState>();

  RegistrationScreen({this.cartItems});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final cpassword = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  _register(BuildContext context, User user) async {
    var _userService = UserService();
    var registeredUser = await _userService.createUser(user);
    var result = json.decode(registeredUser.body);
    if (result['result'] == true) {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setInt('userId', result['user']['id']);
      _prefs.setString('userName', result['user']['username']);
      _prefs.setString('userEmail', result['user']['email']);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CheckoutScreen(
                    cartItems: this.widget.cartItems,),),);} else {_showSnackMessage(Text('Failed to register the user!',
        style: TextStyle(color: Colors.red),
      ));
    }
  }



  _showSnackMessage(message) {
    var snackBar = SnackBar(
      content: message,
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
        padding: const EdgeInsets.only(top: 100.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
              child: TextFormField(
                controller: name,
                onSaved: (String value) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration:
                    InputDecoration(hintText: '', labelText: 'Username'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: email,
                decoration: InputDecoration(
                    // hintText: 'Phone number',
                    labelText: 'Email Address'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
              child: TextField(
                controller: password,

                obscureText: true,
                decoration: InputDecoration(
                    // hintText: 'Password',
                    labelText: 'Password'),
              ),
            ),


            Column(
              children: <Widget>[
                ButtonTheme(
                  minWidth: 320.0,
                  height: 45.0,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0)),
                    color: Colors.redAccent,
                    onPressed: () {
                      var user = User();
                      user.username = name.text;
                      user.email = email.text;
                      user.password = password.text;
                      _register(context, user);
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(builder: (context) => OtpScreens()),
//                      );
                      print("Hello" + "  " + email.value.text);
                    },

                    child:
                        Text('Register', style: TextStyle(color: Colors.white)),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(5),
                  child: FlatButton(
                    child: FittedBox(child: Text('Log in to your account')),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(
                  left: 65.0, top: 14.0, right: 65.0, bottom: 14.0),
              child: Text(
                'By signing up you accept the Terms of Service and Privacy Policy',
                textAlign: TextAlign.center,
              ),
            ),
//      Padding(
//              padding: const EdgeInsets.symmetric(vertical: 16.0),
//              child: ElevatedButton(
////                onPressed: () {
//////                  if (_scaffoldKey.currentState.validate()) {
//////                    Navigator.push(
//////                      context,
//////                      MaterialPageRoute(builder: (context) => OtpScreens()),
//////                    );
//////                  }else{
//////                  }
//////                },
//                child: Text('Submit'),
//              ),
//            ),
          ],
        ),
      ),

//    body:  Container(
//      alignment: Alignment.center,
//        child: Padding(
//          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//          child: MyCustomForm(),
//        )),
    );
  }
}

//class MyCustomForm extends StatefulWidget {
//  @override
//  MyCustomFormState createState() {
//    return MyCustomFormState();
//  }
//}
//
//class MyCustomFormState extends State<MyCustomForm> {
//  final _formKey = GlobalKey<FormState>();
//
//  @override
//  Widget build(BuildContext context) {
//    return Form(
//      key: _formKey,
//      child: SingleChildScrollView(
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.center,
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: TextFormField(
//                decoration: const InputDecoration(
////                  border: OutlineInputBorder(),
//                border: UnderlineInputBorder(),
//                  hintText: 'Enter Username',
//                  labelText: 'Username',
//                ),
//                onSaved: (String value) {
//                },
//
//                validator: (value) {
//                  if (value == null || value.isEmpty) {
//                    return 'Please enter some text';
//                  }
//                  return null;
//                },
//              ),
//            ),
//
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: TextFormField(
//                decoration: const InputDecoration(
//                  border: OutlineInputBorder(),
//                  hintText: 'Enter Email Address',
//                  labelText: 'Email Address',
//                ),
//                onSaved: (String value) {
//                },
//                validator: (value) {
//                  if (value == null || value.isEmpty) {
//                    return 'Please enter some text';
//                  }
//                  return null;
//                },
//              ),
//            ),
//
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: TextFormField(
//                decoration: const InputDecoration(
//                  border: OutlineInputBorder(),
//                  hintText: 'Enter Password',
//                  labelText: 'Password',
//                ),
//                onSaved: (String value) {
//                },
//                validator: (value) {
//                  if (value == null || value.isEmpty) {
//                    return 'Please enter some text';
//                  }
//                  return null;
//                },
//              ),
//            ),
//
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: TextFormField(
//                controller: cpassword,
//                decoration: const InputDecoration(
//                  border: OutlineInputBorder(),
//                  hintText: 'Enter Confirm Password',
//                  labelText: 'Confirm Password',
//                ),
//                onSaved: (String value) {
//                },
//                validator: (value) {
//                  if (value == null || value.isEmpty) {
//                    return 'Please enter some text';
//                  }
//                  return null;
//                },
//              ),
//            ),
//            Padding(
//              padding: const EdgeInsets.symmetric(vertical: 16.0),
//              child: ElevatedButton(
//                onPressed: () {
//                  if (_formKey.currentState.validate()) {
//                    var user = User();
//                      user.username = name.text;
//                      user.email = email.text;
//                      user.password = password.text;
//                      _register(context, user);
//                  }else{
//                  }
//                },
//                child: Text('Submit'),
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
