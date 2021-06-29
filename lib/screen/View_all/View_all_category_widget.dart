import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kate_botique_app/models/category.dart';
import 'package:kate_botique_app/screen/View_all/view_all_category.dart';
import 'package:kate_botique_app/services/category_service.dart';

class ViewAllCategoryWidget extends StatefulWidget {
  @override
  _ViewAllCategoryWidgetState createState() => _ViewAllCategoryWidgetState();
}

class _ViewAllCategoryWidgetState extends State<ViewAllCategoryWidget> {
  CategoryService _categoryService = CategoryService();

  var items = [];
  List<Category> _categoryList = List<Category>();

  @override
  void initState() {
    super.initState();
    _getAllCategories();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,),
        onPressed: (){
          Navigator.pop(context);
        },)
      ),
      body: Container(
          child: ListView(
            children: <Widget>[
              ViewAllCategory(
                categoryList: _categoryList,
              ),
            ],
          )),
    );
  }
}


