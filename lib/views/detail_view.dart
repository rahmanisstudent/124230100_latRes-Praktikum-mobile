import 'package:flutter/material.dart';
import 'package:latihan_responsi/models/news_item.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailView extends StatelessWidget {
  final NewsItem item;

  const DetailView({super.key, required this.item});

  // Fungsi untuk membuka link di browser
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(item.imageUrl, width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(item.newsSite, style: const TextStyle(color: Colors.grey)),
                  Text(item.publishedAt, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 20),
                  Text(item.summary, style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _launchURL(item.url),
        tooltip: 'Buka Web',
        child: const Icon(Icons.launch),
      ),
    );
  }
}