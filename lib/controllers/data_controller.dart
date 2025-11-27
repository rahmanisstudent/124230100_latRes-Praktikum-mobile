import 'package:latihan_responsi/models/news_item.dart';
import 'package:latihan_responsi/services/api_service.dart';

class DataController {
  final ApiService _apiService = ApiService();

  // Mengambil data berdasarkan kategori (articles, blogs, reports)
  Future<List<NewsItem>> getData(String category) async {
    try {
      return await _apiService.fetchItems(category);
    } catch (e) {
      throw Exception('Error loading data: $e');
    }
  }
}