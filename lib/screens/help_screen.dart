import 'package:flutter/material.dart'; // Mengimpor paket material design dari Flutter
import 'package:url_launcher/url_launcher.dart'; // Mengimpor paket untuk meluncurkan URL

class HelpScreen extends StatelessWidget {
  // Kelas HelpScreen yang merupakan widget statis
  // Daftar item bantuan yang berisi judul dan deskripsi
  final List<Map<String, String>> _helpItems = [
    {
      'title': 'Login',
      'description': 'Masukkan username dan password untuk masuk ke aplikasi.',
    },
    {
      'title': 'Stopwatch',
      'description':
          'Fitur penghitung waktu dengan tombol start, pause, dan reset.',
    },
    {
      'title': 'Jenis Bilangan',
      'description':
          'Aplikasi untuk menentukan jenis bilangan (prima, desimal, bulat positif/negatif, cacah).',
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
      'description':
          'Daftar situs yang direkomendasikan dengan gambar dan link.',
    },
    {
      'title': 'Logout',
      'description': 'Keluar dari aplikasi dan menghapus sesi login.',
    },
  ];

  // Daftar pertanyaan yang sering diajukan (FAQ) beserta jawabannya
  final List<Map<String, String>> _faqItems = [
    {
      'question': 'Apakah aplikasi ini gratis?',
      'answer': 'Ya, aplikasi ini sepenuhnya gratis untuk digunakan.',
    },
    {
      'question': 'Di mana saya dapat menemukan versi terbaru aplikasi?',
      'answer':
          'Anda dapat mengunduh versi terbaru aplikasi dari Google Play Store atau App Store.',
    },
    {
      'question': 'Apa saja persyaratan sistem untuk aplikasi ini?',
      'answer':
          'Aplikasi ini membutuhkan perangkat dengan sistem operasi Android versi 7.0 atau lebih tinggi, atau iOS versi 13.0 atau lebih tinggi.',
    },
  ];

  // Variabel untuk menyimpan informasi kontak
  final String _contactEmail = 'dukungan@myapp.com';
  final String _contactPhone = '+6281223222222';
  final String _websiteUrl = 'https://www.myapp.com';

  // Fungsi untuk meluncurkan URL
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url); // Mengonversi string URL menjadi Uri
    if (!await launchUrl(uri)) {
      // Mencoba meluncurkan URL
      throw Exception(
        'Could not launch $url',
      ); // Menangani kesalahan jika gagal
    }
  }

  @override
  Widget build(BuildContext context) {
    // Metode untuk membangun antarmuka pengguna
    return Scaffold(
      // Struktur dasar untuk layar
      body: Container(
        // Kontainer untuk menampung semua konten
        decoration: BoxDecoration(
          // Menambahkan dekorasi latar belakang
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blueAccent.withOpacity(0.1),
              Colors.white,
            ], // Gradien warna
          ),
        ),
        child: SingleChildScrollView(
          // Memungkinkan konten untuk digulir
          padding: EdgeInsets.all(16), // Padding di sekitar konten
          child: Column(
            // Kolom untuk menampung semua widget
            crossAxisAlignment:
                CrossAxisAlignment.start, // Menyusun widget di sisi kiri
            children: [
              Text(
                // Judul utama
                'Bantuan',
                style: TextStyle(
                  color: Colors.blue.shade800,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24), // Jarak vertikal
              Text(
                // Subjudul untuk panduan penggunaan
                'Panduan Penggunaan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 12), // Jarak vertikal
              ListView.builder(
                // Membuat daftar item bantuan
                shrinkWrap:
                    true, // Mengatur ukuran daftar agar sesuai dengan konten
                physics:
                    NeverScrollableScrollPhysics(), // Menonaktifkan scroll pada ListView
                itemCount: _helpItems.length, // Jumlah item dalam daftar
                itemBuilder: (context, index) {
                  // Membangun setiap item
                  return Card(
                    // Menggunakan Card untuk setiap item margin: EdgeInsets.symmetric(vertical: 8), // Margin vertikal untuk jarak antar kartu
                    elevation: 2, // Efek bayangan pada kartu
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        12,
                      ), // Sudut melengkung pada kartu
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16), // Padding di dalam kartu
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start, // Menyusun konten di sisi kiri
                        children: [
                          Text(
                            _helpItems[index]['title']!, // Menampilkan judul item bantuan
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade700, // Warna judul
                            ),
                          ),
                          SizedBox(height: 8), // Jarak vertikal
                          Text(
                            _helpItems[index]['description']!, // Menampilkan deskripsi item bantuan
                            style: TextStyle(
                              color: Colors.grey.shade600, // Warna deskripsi
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 24), // Jarak vertikal
              Text(
                // Subjudul untuk FAQ
                'FAQ (Pertanyaan yang Sering Diajukan)',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 12), // Jarak vertikal
              ListView.builder(
                // Membuat daftar FAQ
                shrinkWrap:
                    true, // Mengatur ukuran daftar agar sesuai dengan konten
                physics:
                    NeverScrollableScrollPhysics(), // Menonaktifkan scroll pada ListView
                itemCount: _faqItems.length, // Jumlah item dalam daftar FAQ
                itemBuilder: (context, index) {
                  // Membangun setiap item FAQ
                  return Card(
                    // Menggunakan Card untuk setiap item FAQ
                    margin: EdgeInsets.symmetric(
                      vertical: 8,
                    ), // Margin vertikal untuk jarak antar kartu
                    elevation: 2, // Efek bayangan pada kartu
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        12,
                      ), // Sudut melengkung pada kartu
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16), // Padding di dalam kartu
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start, // Menyusun konten di sisi kiri
                        children: [
                          Text(
                            _faqItems[index]['question']!, // Menampilkan pertanyaan FAQ
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade700, // Warna pertanyaan
                            ),
                          ),
                          SizedBox(height: 8), // Jarak vertikal
                          Text(
                            _faqItems[index]['answer']!, // Menampilkan jawaban FAQ
                            style: TextStyle(
                              color: Colors.grey.shade600, // Warna jawaban
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 24), // Jarak vertikal
              Text(
                // Subjudul untuk kontak dukungan
                'Kontak Dukungan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 12), // Jarak vertikal
              Card(
                // Kartu untuk menampilkan informasi kontak
                elevation: 2, // Efek bayangan pada kartu
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    12,
                  ), // Sudut melengkung pada kartu
                ),
                child: Padding(
                  padding: EdgeInsets.all(16), // Padding di dalam kartu
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start, // Menyusun konten di sisi kiri
                    children: [
                      Row(
                        // Baris untuk menampilkan email
                        children: [
                          Icon(
                            Icons.email,
                            color: Colors.blue.shade600,
                          ), // Ikon email
                          SizedBox(width: 8), // Jarak horizontal
                          InkWell(
                            // Widget yang dapat diklik
                            onTap:
                                () => _launchURL(
                                  'mailto:$_contactEmail',
                                ), // Meluncurkan email
                            child: Text(
                              _contactEmail, // Menampilkan alamat email
                              style: TextStyle(
                                color: Colors.blue.shade600,
                              ), // Warna teks email
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8), // Jarak vertikal
                      Row(
                        // Baris untuk menampilkan nomor telepon
                        children: [
                          Icon(
                            Icons.phone,
                            color: Colors.green.shade600,
                          ), // Ikon telepon
                          SizedBox(width: 8), // Jarak horizontal
                          InkWell(
                            // Widget yang dapat diklik
                            onTap:
                                () => _launchURL(
                                  'tel:$_contactPhone',
                                ), // Meluncurkan panggilan telepon
                            child: Text(
                              _contactPhone, // Menampilkan nomor telepon
                              style: TextStyle(
                                color: Colors.green.shade600,
                              ), // Warna teks nomor telepon
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8), // Jarak vertikal
                      Row(
                        // Baris untuk menampilkan situs web
                        children: [
                          Icon(
                            Icons.web,
                            color: Colors.orange.shade600,
                          ), // Ikon situs web
                          SizedBox(width: 8), // Jarak horizontal
                          InkWell(
                            // Widget yang dapat diklik
                            onTap:
                                () => _launchURL(
                                  _websiteUrl,
                                ), // Meluncurkan situs web
                            child: Text(
                              _websiteUrl, // Menampilkan URL situs web
                              style: TextStyle(
                                color: Colors.orange.shade600,
                              ), // Warna teks URL
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32), // Jarak vertikal
              Center(
                // Menyusun teks versi aplikasi di tengah
                child: Text(
                  'Versi Aplikasi: 1.0.0', // Menampilkan versi aplikasi
                  style: TextStyle(
                    color: Colors.grey.shade500,
                  ), // Warna teks versi
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  HelpScreen({super.key}); // Konstruktor untuk kelas HelpScreen
}
