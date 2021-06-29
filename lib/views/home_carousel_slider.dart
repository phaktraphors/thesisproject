import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

Widget carouselSlider(items) => SizedBox(
  height: 200,
  
  child: Carousel(
    boxFit: BoxFit.fill,
    dotSize: 4.0,
    dotSpacing: 15.0,
    dotColor: Colors.red,
    indicatorBgPadding: 5.0,
    dotBgColor: Colors.transparent,
    images: items,
    autoplay: true,
    animationCurve: Curves.fastOutSlowIn,
    animationDuration: Duration(milliseconds: 800),
  ),
);


