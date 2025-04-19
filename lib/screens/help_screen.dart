import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatelessWidget {
  final List<Map<String, String>> _helpItems = [
    {
      'title': 'Login',
      'description': 'Masukkan username dan password untuk masuk ke aplikasi.',
    },
    {
      'title': 'Stopwatch',
      'description': 'Fitur penghitung waktu dengan tombol start, pause, dan reset.',
    },
    {
      'title': 'Jenis Bilangan',
      'description': 'Aplikasi untuk menentukan jenis bilangan (prima, desimal, bulat positif/negatif, cacah).',
    },
    {
      'title': 'Tracking LBS',
      'description': 'Fitur untuk melacak lokasi Anda menggunakan TomTom API.',
    },
    {
      'title': 'Konversi Waktu',
      'description': 'Konversi waktu dari tahun ke jam, menit, dan detik.',
    },
    {
      'title': 'Situs Rekomendasi',
      'description': 'Daftar situs yang direkomendasikan dengan gambar dan link.',
    },
    {
      'title': 'Logout',
      'description': 'Keluar dari aplikasi dan menghapus sesi login.',
    },
  ];

  final List<Map<String, String>> _faqItems = [
    {
      'question': 'Apakah aplikasi ini gratis?',
      'answer': 'Ya, aplikasi ini sepenuhnya gratis untuk digunakan.',
    },
    {
      'question': 'Di mana saya dapat menemukan versi terbaru aplikasi?',
      'answer': 'Anda dapat mengunduh versi terbaru aplikasi dari Google Play Store atau App Store.',
    },
    {
      'question': 'Apa saja persyaratan sistem untuk aplikasi ini?',
      'answer': 'Aplikasi ini membutuhkan perangkat dengan sistem operasi Android versi 7.0 atau lebih tinggi, atau iOS versi 13.0 atau lebih tinggi.',
    },
  ];

  final String _contactEmail = 'dukungan@aplikasimu.com';
  final String _contactPhone = '+6281223222222';
  final String _websiteUrl = 'https://www.aplikasimu.com';

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueAccent.withOpacity(0.1), Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bantuan',
                style: TextStyle(
                  color: Colors.blue.shade800,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Panduan Penggunaan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 12),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _helpItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _helpItems[index]['title']!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade700,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            _helpItems[index]['description']!,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 24),
              Text(
                'FAQ (Pertanyaan yang Sering Diajukan)',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 12),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _faqItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _faqItems[index]['question']!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade700,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            _faqItems[index]['answer']!,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 24),
              Text(
                'Kontak Dukungan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 12),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.email, color: Colors.blue.shade600),
                          SizedBox(width: 8),
                          InkWell(
                            onTap: () => _launchURL('mailto:$_contactEmail'),
                            child: Text(
                              _contactEmail,
                              style: TextStyle(color: Colors.blue.shade600),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.phone, color: Colors.green.shade600),
                          SizedBox(width: 8),
                          InkWell(
                            onTap: () => _launchURL('tel:$_contactPhone'),
                            child: Text(
                              _contactPhone,
                              style: TextStyle(color: Colors.green.shade600),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.web, color: Colors.orange.shade600),
                          SizedBox(width: 8),
                          InkWell(
                            onTap: () => _launchURL(_websiteUrl),
                            child: Text(
                              _websiteUrl,
                              style: TextStyle(color: Colors.orange.shade600),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32),
              Center(
                child: Text(
                  'Versi Aplikasi: 1.0.0', // Ganti dengan versi aplikasi Anda
                  style: TextStyle(color: Colors.grey.shade500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  HelpScreen({super.key});
}