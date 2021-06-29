import 'package:flutter/material.dart';
import 'package:kate_botique_app/screen/login.dart';
import 'package:kate_botique_app/screen/login_screen.dart';
import 'package:otp_screen/otp_screen.dart';

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

class SuccessfulOtpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: LoginScreen(),
    );
  }
}

class OtpScreens extends StatelessWidget {
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
        subTitle: "Enter the code sent to \n lynavin94@gmail.com",
        icon: Image.asset(
          'images/phone_logo.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
