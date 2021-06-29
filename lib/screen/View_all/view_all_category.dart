import 'package:kate_botique_app/models/category.dart';
import 'package:flutter/material.dart';
import 'package:kate_botique_app/views/home_product_category.dart';

class ViewAllCategory extends StatefulWidget {
  final List<Category> categoryList;
  ViewAllCategory({this.categoryList});
  @override
  _ViewAllCategoryState createState() => _ViewAllCategoryState();
}

class _ViewAllCategoryState extends State<ViewAllCategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisExtent: 200,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemCount: this.widget.categoryList.length,
          itemBuilder: (context, index) {
            return HomeProductCategory(
                this.widget.categoryList[index].icon,
                this.widget.categoryList[index].name,
                this.widget.categoryList[index].id);
          },
        ),
      ),
    );
  }
}
