import 'package:flutter/material.dart';
import 'package:kate_botique_app/providers/cart_provider.dart';
import 'package:kate_botique_app/screen/View_all/View_all_category_widget.dart';
import 'package:kate_botique_app/screen/homescreen.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: CartProvider(),
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
