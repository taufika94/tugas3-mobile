import 'package:flutter/material.dart';

// Kelas MemberListScreen adalah widget stateless yang menampilkan daftar anggota.
class MemberListScreen extends StatelessWidget {
  // Daftar anggota yang berisi nama dan NIM (Nomor Induk Mahasiswa).
  final List<Map<String, String>> members = [
    {
      'name': 'Nazhif Alaudin Fahmi',
      'nim': '123220063',
    },
    {
      'name': 'Seftian Alung Qiu Prakoso',
      'nim': '123220112',
    },
    {
      'name': 'Taufika Retno Wulan',
      'nim': '123220196',
    },
  ];

  // Konstruktor untuk MemberListScreen.
  MemberListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          // Mengatur latar belakang dengan gradien.
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueAccent.withOpacity(0.1), Colors.white],
          ),
        ),
        child: Column(
          children: [
            // Judul daftar anggota.
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16), // Menambahkan padding horizontal.
              child: Align(
                alignment: Alignment.centerLeft, // Menyelaraskan teks ke kiri.
                child: Text(
                  'Daftar Anggota', // Teks judul.
                  style: TextStyle(
                    color: Colors.blue.shade800,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              // Menggunakan ListView untuk menampilkan daftar anggota.
              child: ListView.separated(
                padding: EdgeInsets.all(16), // Padding untuk ListView.
                itemCount: members.length, // Jumlah item yang ditampilkan.
                separatorBuilder: (context, index) => SizedBox(height: 12), // Pemisah antar item.
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16), // Membuat sudut melengkung.
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueAccent.withOpacity(0.1), // Bayangan untuk efek kedalaman.
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Card(
                      margin: EdgeInsets.zero, // Menghilangkan margin pada kartu.
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16), // Sudut melengkung pada kartu.
                      ),
                      elevation: 0, // Menghilangkan elevasi pada kartu.
                      child: Padding(
                        padding: EdgeInsets.all(16), // Padding di dalam kartu.
                        child: Row(
                          children: [
                            // Lingkaran yang menampilkan huruf pertama dari nama anggota.
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.blueAccent.withOpacity(0.2), // Warna latar belakang lingkaran.
                                shape: BoxShape.circle, // Bentuk lingkaran.
                                border: Border.all(
                                  color: Colors.blueAccent,
                                  width: 2, // Lebar border lingkaran.
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  members[index]['name']![0], // Menampilkan huruf pertama dari nama anggota.
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 16), // Jarak antara lingkaran dan teks.
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start, // Menyelaraskan teks ke kiri.
                                children: [
                                  Text(
                                    members[index]['name']!, // Menampilkan nama anggota.
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 4), // Jarak antara nama dan NIM.
                                  Text(
                                    'NIM: ${members[index]['nim']}', // Menampilkan NIM anggota.
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Ikon untuk menunjukkan anggota.
                            Icon(
                              Icons.person_outline,
                              color: Colors.blueAccent,
                              size: 28,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}