import 'package:flutter/material.dart';
import 'package:latihan_responsi/controllers/data_controller.dart';
import 'package:latihan_responsi/models/news_item.dart';
import 'package:latihan_responsi/views/detail_view.dart';

class ItemListView extends StatefulWidget {
  final String category;
  final String title;

  const ItemListView({super.key, required this.category, required this.title});

  @override
  State<ItemListView> createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  final DataController _controller = DataController();
  late Future<List<NewsItem>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = _controller.getData(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),backgroundColor: Colors.blueAccent,foregroundColor: Colors.white,),
      body: FutureBuilder<List<NewsItem>>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Tidak ada data ditemukan."));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final item = snapshot.data![index];
              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: Image.network(
                    item.imageUrl, 
                    width: 80, 
                    height: 80, 
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, error, stackTrace) => const Icon(Icons.broken_image),
                  ),
                  title: Text(item.title, maxLines: 2, overflow: TextOverflow.ellipsis),
                  subtitle: Text(item.newsSite),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailView(item: item),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}