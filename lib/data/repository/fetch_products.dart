import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:royalmart/data/model/product.dart';
import 'package:royalmart/data/model/product_model.dart';

// class ApiService {
//   final String _baseUrl = 'https://fakestoreapi.com/products';

//   Future<List<ProductModel>> fetchProducts() async {
//     try {
//       final response = await http.get(Uri.parse(_baseUrl));

//       if (response.statusCode == 200) {
//         final List<dynamic> jsonData = jsonDecode(response.body);
//         return jsonData.map((json) => ProductModel.fromJson(json)).toList();
//       } else {
//         throw Exception('Failed to load products: Status Code ${response.statusCode}');
//       }
//     } on Exception catch (e) {
//       throw Exception('An error occurred: $e');
//     }
//   }
// }


import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String url = 'https://fakestoreapi.com/products';

  Future<List<ProductModel>> fetchProducts() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}