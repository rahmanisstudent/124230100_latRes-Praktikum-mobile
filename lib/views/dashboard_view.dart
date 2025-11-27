import 'package:flutter/material.dart';
import 'package:latihan_responsi/controllers/auth_controller.dart';
import 'package:latihan_responsi/services/session_service.dart';
import 'package:latihan_responsi/views/list_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final AuthController _authController = AuthController();
  final SessionService _sessionService = SessionService();
  String? username;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    String? user = await _sessionService.getUsername();
    setState(() {
      username = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hai, ${username ?? "User"}!'), // Menampilkan username di AppBar
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Tombol Menu (News, Blog, Report) bisa ditambahkan di sini nanti
              _buildMenuButton(
              context,
              "News",
              "articles",
              "Get an overview of the latest SpaceFlight news, from various sources! Easily link your users to the right websites.",
              Icons.newspaper,
            ),
              const SizedBox(height: 15),
              _buildMenuButton(
              context,
              "Blog",
              "blogs",
              "Blogs often provide a more detailed overview of launches and missions. A must-have for the serious spaceflight enthusiast.",
              Icons.article_outlined, // Atau Icons.book
            ),
              const SizedBox(height: 15),
              _buildMenuButton(
              context,
              "Reports",
              "reports",
              "Space stations and other missions often publish their data. With SNAPI, you can include it in your app.",
              Icons.analytics_outlined, // Atau Icons.bar_chart
            ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  // Panggil fungsi logout dari Controller
                  _authController.logout(context);
                },
                child: const Text('Log Out', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildMenuButton(
    BuildContext context,
    String title,
    String category,
    String description, // Tambahan parameter deskripsi
    IconData icon,
  ) {
    return Card(
      elevation: 4.0, // Memberi bayangan agar terlihat seperti tombol timbul
      margin: const EdgeInsets.symmetric(vertical: 10), // Jarak antar tombol
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Sudut yang membulat
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemListView(category: category, title: title),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Jarak konten di dalam card
          child: Row(
            children: [
              // Bagian Kiri: ICON
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50, // Warna background icon tipis
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 36,
                  color: Colors.deepPurple, // Sesuaikan warna tema
                ),
              ),
              const SizedBox(width: 16), // Jarak antara icon dan teks
              
              // Bagian Kanan: TEKS (Judul & Deskripsi)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                      maxLines: 3, // Batasi maksimal 3 baris
                      overflow: TextOverflow.ellipsis, // Tambahkan titik-titik jika kepanjangan
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }