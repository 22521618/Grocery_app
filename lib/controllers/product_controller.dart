import 'dart:convert';

import 'package:grocery_app/global_variable.dart';
import 'package:grocery_app/models/product.dart';
import 'package:http/http.dart' as http;

class ProductController {
  Future<List<Product>> loadPopularProduct() async {
    try {
      // send an http get request to load the categories
      http.Response response = await http.get(
        Uri.parse('$uri/api/popular-products'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
      );

      print(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;

        List<Product> products = data
            .map((product) => Product.fromMap(product as Map<String, dynamic>))
            .toList();
        return products;
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      throw Exception("Error to loading products $e");
    }
  }

  Future<List<Product>> loadProductByCategory(String category) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/products-by-category/$category'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        // Decode the json response body into a list of dynamic object
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;

        // Map each items in the list to product model object which we can use
        List<Product> products = data
            .map((product) => Product.fromMap(product as Map<String, dynamic>))
            .toList();

        return products;
      } else {
        // If status code is not 200, throw an exception indicating failure to load the popular products
        throw Exception('Failed to load  product by category');
      }
    } catch (e) {
      // Handle exceptions here
      throw Exception("Error to loading products by catefory $e");
    }
  }
}
