import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kate_botique_app/helpers/side_drawer_navigation.dart';
import 'package:kate_botique_app/models/category.dart';
import 'package:kate_botique_app/models/product.dart';
import 'package:kate_botique_app/providers/cart_provider.dart';
import 'package:kate_botique_app/screen/View_all/View_all_category_widget.dart';
import 'package:kate_botique_app/screen/cart_screen.dart';
import 'package:kate_botique_app/services/cate_service.dart';
import 'package:kate_botique_app/services/category_service.dart';
import 'package:kate_botique_app/services/product_service.dart';
import 'package:kate_botique_app/services/slider_service.dart';
import 'package:kate_botique_app/views/home_carousel_slider.dart';
import 'package:kate_botique_app/views/home_hot_product_patial.dart';
import 'package:kate_botique_app/views/home_product_category_patial.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Request services
  SliderService _sliderService = SliderService();
  CategoryService _categoryService = CategoryService();
  ProductService _productService = ProductService();
  CartService _cartService = CartService();

  /// End of request services
  var items = [];
  List<Category> _categoryList = List<Category>();
  List<Product> _productList = List<Product>();
  List<Product> _cartItems;

  @override
  void initState() {
    super.initState();
    _getAllSliders();
    _getAllCategories();
    _getAllHotProducts();
    _getCartItems();
  }

  /// block of function
  _getCartItems() async {
    _cartItems = List<Product>();
    var cartItems = await _cartService.getCartItems();
    cartItems.forEach((data) {
      var product = Product();
      product.id = data['productId'];
      product.name = data['productName'];
      product.photo = data['productPhoto'];
      product.price = data['productPrice'];
      product.discount = data['productDiscount'];
      product.productDetail = data['productDetail'] ?? 'No detail';
      product.quantity = data['productQuantity'];
      setState(() {
        _cartItems.add(product);
      });
    });
  }

  _getAllSliders() async {
    var sliders = await _sliderService.getSliders();
    var result = json.decode(sliders.body);
    result['data'].forEach((data) {
      setState(() {
        items.add(NetworkImage(data['image_url']));
      });
    });
  }

  _getAllCategories() async {
    var categories = await _categoryService.getCategories();
    var result = json.decode(categories.body);
    result['data'].forEach((data) {
      var model = Category();
      model.id = data['id'];
      model.name = data['cate_name'];
      model.icon = data['icon'];
      setState(() {
        _categoryList.add(model);
      });
    });
  }

  _getAllHotProducts() async {
    var hotProducts = await _productService.getHotProducts();
    var result = json.decode(hotProducts.body);

    result['data'].forEach((data) {
      var model = Product();
      model.id = data['id'];
      model.name = data['pro_name'];
      model.photo = data['photo'];
      model.price = data['price'];
      model.discount = data['discount'];
      model.productDetail = data['desc'];

      setState(() {
        _productList.add(model);
      });
    });
  }

  /// end block of function

  @override
  Widget build(BuildContext context) {

    final cartProvider = Provider.of<CartProvider>(context);
    cartProvider.cartItems();
    return Scaffold(
      drawer: SideDrawerNavigation(),
      appBar: AppBar(
        title: Text('Kate Botique'),
        centerTitle: true,
        backgroundColor: Colors.pink,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(_cartItems),
                  ),
                );
              },
              child: Container(
                height: 150,
                width: 30,
                child: Stack(
                  children: <Widget>[
                    IconButton(
                      iconSize: 30,
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    Positioned(
                      child: Stack(
                        children: <Widget>[
                          Icon(Icons.brightness_1,
                              size: 25, color: Colors.deepOrangeAccent),
                          Positioned(
                            top: 4.0,
                            right: 8.0,
                            child: Center(child: Text(_cartItems.length.toString())),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
          child: ListView(
        children: <Widget>[
          carouselSlider(items),
              Padding(padding: EdgeInsets.all(10.0),
                child: Row(
                  children:<Widget> [
                  Expanded(
                    child: Text('Category',style: GoogleFonts.roboto(fontSize: 20.0), textAlign: TextAlign.start,),),
                  Expanded(
                    child: InkWell(
                      onTap: (){},
//                      child: Text("View All", style: TextStyle(fontSize: 18.0, color: Colors.blue), textAlign: TextAlign.end,)
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewAllCategoryWidget()));
                        print("category click");
                      },
                      child: Text(
                        'View All',
                        style: GoogleFonts.mcLaren(
                          textStyle: TextStyle(color: Colors.blue,fontSize: 18),
                        ),textAlign: TextAlign.end,
                      ),
                    ),
                     ),
                  ),
                 ],
                ),
              ),
          HomeProductCategories(
            categoryList: _categoryList,
          ),
          Padding(padding: EdgeInsets.all(10.0),
            child: Row(
              children:<Widget> [
                Expanded(
                  child: Text('Hot Product',style: GoogleFonts.roboto(fontSize: 20.0), textAlign: TextAlign.start,),),
                Expanded(
                  child: InkWell(
                      onTap: (){},
                      child: Text("View All", style: TextStyle(fontSize: 18.0, color: Colors.blue), textAlign: TextAlign.end,)),
                ),
              ],
            ),
          ),
          HomeHotProducts(
            productList: _productList,
          ),
          SizedBox(height: 20.0,)
        ],
      )),
    );
  }
}


