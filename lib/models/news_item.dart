class NewsItem {
  final int id;
  final String title;
  final String imageUrl;
  final String summary;
  final String url; // Link ke website asli
  final String publishedAt;
  final String newsSite;

  NewsItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.summary,
    required this.url,
    required this.publishedAt,
    required this.newsSite,
  });

  // Factory method untuk mengubah JSON menjadi Object NewsItem
  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      id: json['id'],
      title: json['title'] ?? 'No Title',
      imageUrl: json['image_url'] ?? '',
      summary: json['summary'] ?? 'No Summary',
      url: json['url'] ?? '',
      publishedAt: json['published_at'] ?? '',
      newsSite: json['news_site'] ?? 'Unknown',
    );
  }
}