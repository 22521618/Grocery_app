import 'package:flutter/material.dart';
import 'package:grocery_app/views/screens/nav_screens/widgets/banner_widget.dart';
import 'package:grocery_app/views/screens/nav_screens/widgets/category_item_widget.dart';
import 'package:grocery_app/views/screens/nav_screens/widgets/header_widget.dart';
import 'package:grocery_app/views/screens/nav_screens/widgets/popular_product_widget.dart';
import 'package:grocery_app/views/screens/nav_screens/widgets/reusable_test_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderWidget(),
            BannerWidget(),
            CategoryItemWidget(),
            ReusableTestWidget(
                title: "Popular products", subtitile: "View all"),
            PopularProductWidget(),
          ],
        ),
      ),
    );
  }
}
