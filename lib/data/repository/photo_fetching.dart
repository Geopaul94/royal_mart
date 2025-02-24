
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:royalmart/data/model/photo_model.dart';




class PexelsApiService {
  final String apiKey = 'FeJ8k3eJyELP82hkVGudyqdleoGQqeBLTyzCgwplrsKfVrnkYuduFbBY';
final String apiUrl = 'https://api.pexels.com/v1/search';

   


  Future<List<ImageModel>> fetchClothingModelImages(int page) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl?query=clothing&per_page=10&page=$page'),
        headers: {
          'Authorization': apiKey,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<ImageModel> images = (data['photos'] as List<dynamic>).map((photo) {
          return ImageModel.fromJson(photo);
        }).toList();
        return images;
      } else {
        throw Exception('Failed to load images: Status Code ${response.statusCode}');
      }
    } on SocketException catch (se) {
      throw Exception('Network issue: $se');
    } on HttpException catch (he) {
      throw Exception('HTTP error: $he');
    } on FormatException catch (fe) {
      throw Exception('Format issue: $fe');
    } catch (e) {
      throw Exception('Error fetching images: $e');
    }
  }
}
