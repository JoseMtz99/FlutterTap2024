import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:tap2024/models/popular_model.dart';
class ApiPopular {
  Uri uri = Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=1ccb4a0133b640b0009111d24d5ef950&language=es-MX&page=1');

  Future<List<PopularModel>?> getAllPopular() async {
    Response response = await http.get(uri);
    if (response.statusCode==200) {
      final jsonPopular = jsonDecode(response.body)['results'] as List;
      return jsonPopular.map((popular) => PopularModel.fromMapp(popular)).toList();
    }
    return null;
  }
}