
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kate_botique_app/models/category.dart';
import 'package:kate_botique_app/models/product.dart';
import 'package:kate_botique_app/screen/cart_screen.dart';
import 'package:kate_botique_app/services/cate_service.dart';
import 'package:kate_botique_app/services/category_service.dart';
import 'package:kate_botique_app/views/home_carousel_slider.dart';
import 'package:kate_botique_app/views/home_product_category_patial.dart';

class ProductDetail extends StatefulWidget {
  final Product product;

  ProductDetail(this.product);
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CartService _cartService = CartService();
  CategoryService _categoryService = CategoryService();
  List<Product> _cartItems;
  var items = [];
  List<Category> _categoryList = List<Category>();

  @override
  void initState() {
    super.initState();
    _getCartItems();
    _getAllCategories();
  }

  _getCartItems() async {
    _cartItems = List<Product>();
    var cartItems = await _cartService.getCartItems();
    cartItems.forEach((data){
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

  _addToCart(BuildContext context, Product product) async {
    var result = await _cartService.addToCart(product);
    if(result > 0){
      _getCartItems();
      // _showSnackMessage(Text('Item added to cart successfully!', style: TextStyle(color: Colors.green),));
    } else {
      // _showSnackMessage(Text('Failed to add to cart!', style: TextStyle(color: Colors.red),));
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
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(this.widget.product.name),
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(_cartItems)));
            },
                      child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 150,
                width: 30,
                child: Stack(
                  children: <Widget>[
                    IconButton(
                      iconSize: 30,
                      icon: Icon(Icons.shopping_cart, color: Colors.white,),
                      onPressed: (){
                      },
                    ),

                    Positioned(
                      child: Stack(
                        children: <Widget>[
                          Icon(Icons.brightness_1, size: 25, color:Colors.black),
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

      body: ListView(
        children: <Widget>[
          Container(
            height: 300,
            child: GridTile(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  child: Image.network(this.widget.product.photo),
                ),
              ),
              footer: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                    ),
                  ),
                ),
//          ),
        Padding(padding: EdgeInsets.all(3.0),
        child: Row(

        ),),

          Divider(),

          Padding(padding: EdgeInsets.all(3.0),
          child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:<Widget> [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(this.widget.product.name, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
              ),
                  Padding(padding: const EdgeInsets.all(5.0),
                    child: Text.rich(TextSpan(
                      children: <TextSpan>[
                        TextSpan(text: ' Product Price:  ', style: TextStyle(fontStyle: FontStyle.italic,fontSize: 20)),
                        TextSpan(text: '\$${this.widget.product.price }', style: TextStyle(color: Colors.redAccent, fontSize: 20, fontWeight: FontWeight.bold,decoration: TextDecoration.lineThrough)),
                      ],
                    )),
            ),

                  Padding(padding: const EdgeInsets.all(5.0),
                    child: Text.rich(TextSpan(
                      children: <TextSpan>[
                        TextSpan(text: ' Discount Price:  ', style: TextStyle(fontStyle: FontStyle.italic,fontSize: 20,)),
                        TextSpan(text: '\$${this.widget.product.price- this.widget.product.discount }', style: TextStyle(color: Colors.redAccent, fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    )),
          ),
//                  Padding(
//                    padding: const EdgeInsets.all(5.0),
//                    child: Text('\$${this.widget.product.price }', style: TextStyle(color: Colors.redAccent, fontSize: 20, fontWeight: FontWeight.bold),),
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.all(5.0),
//                    child: Text('\$${this.widget.product.price - this.widget.product.discount}', style: TextStyle(color: Colors.redAccent, fontSize: 20, fontWeight: FontWeight.bold),),
//                  ),
                  Divider(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  _addToCart(context, this.widget.product);
                },

                textColor: Colors.redAccent,
                child: Row(
                  children: <Widget>[
                    Text('Add to cart'),
                    IconButton(
                      onPressed: (){
                      },
                      icon: Icon(Icons.shopping_cart),
                    )
                  ],
                ),
              ),
                    IconButton(onPressed: (){},
                      icon: Icon(Icons.favorite_border, color: Colors.redAccent,),)],),

          Divider(),

          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: ListTile(
                         title: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text('Product detail', style: TextStyle(fontSize: 20, color: Colors.redAccent),textAlign: TextAlign.center,),
                          ),
              subtitle: Text(this.widget.product.productDetail),
            ),
          ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: ListTile(
                      title: Text('Relate Product', style: TextStyle(fontSize: 20, color: Colors.redAccent),textAlign: TextAlign.center,),
                    ),
                  ),
                  HomeProductCategories(
                    categoryList: _categoryList,
                  ),
//                  ListView(
//                    children: <Widget>[
//                      carouselSlider(items),
//                      HomeProductCategories(
//                        categoryList: _categoryList,
//                      ),
//                    ],
//              ),

//                  Padding(
//                    padding: const EdgeInsets.only(left: 10.0),
//                    child: ListView(
//                      title: Padding(
//                        padding: const EdgeInsets.only(bottom: 10.0),
//                        child: Text('Relate Product', style: TextStyle(fontSize: 20, color: Colors.redAccent),textAlign: TextAlign.center,),
//                      ),
//                    ),
//                  ),

        ],
      ),
    ),
        ),

    ]
      )
    );
  }
}

//
//import 'package:flutter/material.dart';
//import 'package:kate_botique_app/models/product_detail.dart';
//import 'package:kate_botique_app/screen/product_detail_page/product_content_widget.dart';
//import 'package:kate_botique_app/screen/product_detail_page/product_detail_top_bar.dart';
//
//import '../../models/product_detail.dart.dart';
////import 'product_detail_background.dart';
////import 'product_content_widget.dart';
//import 'product_detail_page/product_detail_background.dart';
////import 'product_detail_top_bar.dart';
//
//class ProductDetailPage extends StatelessWidget {
//  final Product product;
//
//  const ProductDetailPage({Key key, @required this.product}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    final screenHeight = MediaQuery.of(context).size.height;
//    final screenWidth = MediaQuery.of(context).size.width;
//
//    return Scaffold(
//      body: Stack(
//        children: <Widget>[
//          ProductDetailBackground(
//            screenHeight: screenHeight,
//            screenWidth: screenWidth,
//          ),
//          SingleChildScrollView(
//            child: Column(
//              children: <Widget>[
//                ProductDetailTopBar(),
//                ProductContentWidget(product: product, screenHeight: screenHeight),
//              ],
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}
