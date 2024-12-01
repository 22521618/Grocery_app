import 'dart:convert';

import 'package:grocery_app/global_variable.dart';
import 'package:grocery_app/models/banner_model.dart';
import 'package:http/http.dart' as http;

class BannerController {
  Future<List<BannerModel>> loadBanners() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/banner'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<BannerModel> banners =
            data.map((banner) => BannerModel.fromJson(banner)).toList();
        return banners;
      } else {
        throw Exception("Failed to load bannerImage");
      }
    } catch (e) {
      throw Exception("Error to loading banners $e");
    }
  }
}
