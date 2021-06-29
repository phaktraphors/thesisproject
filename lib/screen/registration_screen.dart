import 'dart:convert';
import 'package:email_auth/email_auth.dart';
import 'package:kate_botique_app/models/product.dart';
import 'package:kate_botique_app/models/user.dart';
import 'package:kate_botique_app/screen/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:kate_botique_app/screen/login.dart';
import 'package:kate_botique_app/screen/otp_screen.dart';
import 'package:kate_botique_app/services/user_service.dart';
import 'package:otp_screen/otp_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatefulWidget {
  final List<Product> cartItems;
  RegistrationScreen({this.cartItems});

//OTP Screen
  Future<String> validateOtp(String otp) async {
    await Future.delayed(Duration(milliseconds: 2000));
    if (otp == "123456") {
      return null;
    } else {
      return "The entered Otp is wrong";
    }
  }
  void moveToNextScreen(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SuccessfulOtpScreen()));
  }
//End of OTP Screen

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final name = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final email = TextEditingController();

  final password = TextEditingController();

//sent OTP
  void sendOTP() async {
    EmailAuth.sessionName = "Kate Botique Baby Shop";
    bool result = await EmailAuth.sendOtp(receiverMail: email.value.text);
    if (result) {
      print("OTP was send!");
    } else {
      print("We could not send the OTP");
    }
  }

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
              builder: (context) =>
                  CheckoutScreen(
                    cartItems: this.widget.cartItems,
                  )));
    } else {
      _showSnackMessage(Text(
        'Failed to register the user!',
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
              child: TextField(
                controller: name,
                decoration:
                InputDecoration(hintText: '', labelText: 'Username'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
              child: TextField(
//                keyboardType: TextInputType.emailAddress,
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
//                      var user = User();
//                      user.username = name.text;
//                      user.email = email.text;
//                      user.password = password.text;
//                      _register(context, user);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OTPScreen()),

                      );
//                      sendOTP();
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
          ],
        ),
      ),
    );
  }
}

  class OTPScreen extends StatelessWidget {
    final name = TextEditingController();
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final email = TextEditingController();
    final password = TextEditingController();
    var user = User();

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: OtpScreen.withGradientBackground(
          topColor: Color(0xFFcc2b5e),
          bottomColor: Color(0xFF753a88),
          otpLength: 6,
          validateOtp: validateOtp,
          routeCallback: moveToNextScreen,
          themeColor: Colors.white,
          titleColor: Colors.white,
          title: "Email Verification",
          subTitle: "Enter the code sent to \n"+ email.value.text +"hello",
          icon: Image.asset(
            'images/phone_logo.png',
            fit: BoxFit.fill,
          ),
        ),
      );
    }
  }