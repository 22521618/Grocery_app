import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocery_app/controllers/product_controller.dart';
import 'package:grocery_app/models/product.dart';
import 'package:grocery_app/provider/product_provider.dart';
import 'package:grocery_app/views/screens/nav_screens/widgets/product_item_widget.dart';

class PopularProductWidget extends ConsumerStatefulWidget {
  const PopularProductWidget({super.key});

  @override
  ConsumerState<PopularProductWidget> createState() =>
      _PopularProductWidgetState();
}

class _PopularProductWidgetState extends ConsumerState<PopularProductWidget> {
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchProduct();
  }

  Future<void> _fetchProduct() async {
    final ProductController productController = ProductController();

    try {
      final products = await productController.loadPopularProduct();
      ref.read(productProvider.notifier).setProducts(products);
    } catch (e) {
      print("$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productProvider);
    return SizedBox(
      height: 250,
      child: ListView.builder(
        // scrollDirection: Axis.horizontal,
        itemCount: products!.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final product = products[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ProductItemWidget(
              product: product,
            ),
          );
        },
      ),
    );
  }
}
