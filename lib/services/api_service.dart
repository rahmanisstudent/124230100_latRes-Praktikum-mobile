import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latihan_responsi/models/news_item.dart';

class ApiService {
  final String _baseUrl = 'https://api.spaceflightnewsapi.net/v4';

  Future<List<NewsItem>> fetchItems(String endpoint) async {
    final response = await http.get(Uri.parse('$_baseUrl/$endpoint/'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> results = data['results']; 
      
      return results.map((json) => NewsItem.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat data dari $endpoint');
    }
  }
}