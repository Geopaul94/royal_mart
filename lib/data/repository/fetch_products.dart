import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:royalmart/data/model/product_model.dart';


class ApiService {
  static const String url = 'https://fakestoreapi.com/products';

  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}











