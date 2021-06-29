import 'package:flutter/material.dart';
import 'package:kate_botique_app/screen/splash/constants.dart';
import 'package:kate_botique_app/screen/splash/size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key key,
    this.text,
    this.image,
  }) : super(key: key);
  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Text(
          "BOTIQUE SHOP",
          style: TextStyle(
            fontSize: (36),
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Image.asset(
            image,
//          height: getProportionateScreenHeight(265),
//          width: getProportionateScreenWidth(235),
          ),
        ),
      ],
    );
  }
}
