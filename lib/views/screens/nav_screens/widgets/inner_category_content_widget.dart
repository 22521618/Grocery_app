import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/controllers/product_controller.dart';
import 'package:grocery_app/controllers/subcategory_controller.dart';
import 'package:grocery_app/models/category.dart';
import 'package:grocery_app/models/product.dart';
import 'package:grocery_app/models/subcategory.dart';
import 'package:grocery_app/views/screens/nav_screens/widgets/inner_header_widget.dart';
import 'package:grocery_app/views/screens/nav_screens/widgets/innner_banner_widget.dart';
import 'package:grocery_app/views/screens/nav_screens/widgets/product_item_widget.dart';
import 'package:grocery_app/views/screens/nav_screens/widgets/reusable_test_widget.dart';
import 'package:grocery_app/views/screens/nav_screens/widgets/subcategory_title_widget.dart';

class InnerCategoryContentWidget extends StatefulWidget {
  final Category category;
  const InnerCategoryContentWidget({
    super.key,
    required this.category,
  });

  @override
  State<InnerCategoryContentWidget> createState() =>
      _InnerCategoryContentWidgetState();
}

class _InnerCategoryContentWidgetState
    extends State<InnerCategoryContentWidget> {
  late Future<List<Product>> futureProducts;
  late Future<List<Subcategory>> _subcategory;
  final SubcategoryController _subcategoryController = SubcategoryController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _subcategory = _subcategoryController
        .getSubCategoriesByCategoryName(widget.category.name);
    futureProducts =
        ProductController().loadProductByCategory(widget.category.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 20),
        child: InnerHeaderWidget(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InnnerBannerWidget(
              image: widget.category.banner,
            ),
            Center(
              child: Text(
                'Shop By Subcategories',
                style: GoogleFonts.quicksand(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.7,
                ),
              ),
            ),
            FutureBuilder(
              future: _subcategory,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  ); // Center
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text('No Category'),
                  ); // Center
                } else {
                  final subcategories = snapshot.data!;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: List.generate(
                        (subcategories.length / 7).ceil(),
                        (setIndex) {
                          // Tính toán chỉ số bắt đầu và kết thúc cho mỗi hàng
                          final start = setIndex * 7;
                          final end = (setIndex + 1) * 7;

                          // Tạo một padding để thêm khoảng cách xung quanh hàng
                          return Padding(
                            padding: EdgeInsets.all(8.9),
                            child: Row(
                              children: subcategories
                                  .sublist(
                                      start,
                                      end > subcategories.length
                                          ? subcategories.length
                                          : end)
                                  .map((subcategory) => SubcategoryTitleWidget(
                                        image: subcategory.image,
                                        title: subcategory.subCategoryName,
                                      ))
                                  .toList(),

                              // Tạo một hàng chứa các subcategory
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              }, // FutureBuilder
            ),
            ReusableTestWidget(title: 'Popular Product', subtitile: 'View all'),
            FutureBuilder(
                future: futureProducts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text("No  products under this category"),
                    );
                  } else {
                    final products = snapshot.data;
                    final int intCount = products!.length;
                    bool count;
                    if (intCount <= 1) {
                      count = true;
                    } else {
                      count = false;
                    }
                    return SizedBox(
                      height: 250,
                      child: count
                          ? ListView.builder(
                              itemCount: products!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final product = products[index];
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ProductItemWidget(
                                    product: product,
                                  ),
                                );
                              },
                            )
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: products!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final product = products[index];
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ProductItemWidget(
                                    product: product,
                                  ),
                                );
                              },
                            ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
