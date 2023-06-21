import 'package:dio/dio.dart';

import '../models/cat_image_model.dart';
import '../models/cat_model.dart';

class CatService {
  final String cleanUrl = 'https://cleanuri.com/api/v1/shorten';
  final String urlExample = 'https://www.falabella.com.co/falabella-co/product/3470950/Set-de-Poker-de-300-Fichas/3470950';
  final String catUrl = 'https://api.thecatapi.com/v1/breeds?api_key=live_XcwtjuZjTZSf06iHVV8JsRitJlnW4LLj0Gkaw8ZOJVjau2A5SZt1xO6fdrlnCS3f';
  final String catImageUrl = 'https://api.thecatapi.com/v1/images/';

  final Dio _dio = Dio();

  Future<String> postCleanUrl({required String url}) async {
    try {
      final res = await _dio.post(cleanUrl, data: {'url':url});
      final data = res.data['result_url'] as String;
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CatModel>> getCatInfo() async {
    try {
      final res = await _dio.get(catUrl);
      final data = res.data as List;
      return List.from(
        data.map((e) => CatModel.fromJson(e as Map<String, dynamic>)),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<CatImageModel> getCatImage(String id) async {
    try {
      final res = await _dio.get('$catImageUrl$id');
      return CatImageModel.fromJson(res.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

}
