import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import '../widgets/stopwatch_widget.dart';
import '../widgets/number_types_widget.dart';
import '../widgets/location_tracking_widget.dart';
import '../widgets/time_conversion_widget.dart';
import '../widgets/recommended_sites_widget.dart';
import 'member_list_screen.dart';
import 'help_screen.dart';

// Kelas HomeScreen adalah widget stateful yang menjadi layar utama aplikasi.
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// State untuk HomeScreen yang mengelola logika dan tampilan.
class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Menyimpan indeks item yang dipilih di bottom navigation bar.
  String _username = ''; // Menyimpan nama pengguna.

  @override
  void initState() {
    super.initState();
    _checkLoginStatus(); // Memeriksa status login saat inisialisasi.
    _loadUsername(); // Memuat nama pengguna dari SharedPreferences.
  }

  // Memeriksa apakah pengguna sudah login.
  void _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    // Jika belum login, arahkan ke layar login.
    if (!isLoggedIn) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  // Memuat nama pengguna dari SharedPreferences.
  void _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'Pengguna'; // Jika tidak ada, gunakan 'Pengguna' sebagai default.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My APP',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade800,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.blue.shade600,
              child: Text(
                _username.isNotEmpty ? _username[0].toUpperCase() : 'P', // Menampilkan huruf pertama dari nama pengguna.
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueAccent.withOpacity(0.1), Colors.white], // Latar belakang dengan gradien.
          ),
        ),
        child: _selectedIndex == 0
            ? _buildHomeContent() // Konten utama jika indeks 0.
            : _selectedIndex == 1
                ? MemberListScreen() // Menampilkan MemberListScreen jika indeks 1.
                : HelpScreen(), // Menampilkan HelpScreen jika indeks lainnya.
      ),
      bottomNavigationBar: _buildBottomNavigationBar(), // Menampilkan bottom navigation bar.
    );
  }

  // Membuat konten utama di layar beranda.
  Widget _buildHomeContent() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Halo, $_username', // Menyapa pengguna dengan namanya.
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Apa yang ingin Anda lakukan hari ini?', // Pertanyaan untuk pengguna.
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            // Membuat beberapa kartu menu untuk navigasi ke fitur lain.
            _buildMenuCard(
              'Stopwatch',
              Icons.timer,
              Colors.blue.shade700,
              () => _navigateToScreen(StopwatchWidget()),
            ),
            _buildMenuCard(
              'Jenis Bilangan',
              Icons.calculate,
              Colors.green.shade700,
              () => _navigateToScreen(NumberTypesWidget()),
            ),
            _buildMenuCard(
              'Tracking Lokasi',
              Icons.location_on,
              Colors.orange.shade700,
              () => _navigateToScreen(LocationTrackingWidget()),
            ),
            _buildMenuCard(
              'Konversi Waktu',
              Icons.access_time,
              Colors.purple.shade700,
              () => _navigateToScreen(TimeConversionWidget()),
            ),
            _buildMenuCard(
              'Situs Rekomendasi',
              Icons.web,
              Colors.red.shade700,
              () => _navigateToScreen(RecommendedSitesWidget()),
            ),
            SizedBox(height: 24),
            SizedBox( // Menambahkan SizedBox untuk tombol logout.
              width: double.infinity, // Membuat tombol memenuhi lebar.
              child: ElevatedButton(
                onPressed: _logout, // Memanggil fungsi logout saat tombol ditekan.
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, size: 20, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Logout', // Teks tombol logout.
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Membuat kartu menu untuk navigasi ke fitur tertentu.
  Widget _buildMenuCard(
    String title, IconData icon, Color color, VoidCallback onTap) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap, // Menangani tap pada kartu.
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, size: 28, color: color), // Menampilkan ikon.
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title, // Menampilkan judul kartu.
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey.shade500, // Menampilkan panah ke kanan.
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Membuat bottom navigation bar.
  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex, // Menentukan item yang dipilih.
          onTap: _onItemTapped, // Menangani tap pada item.
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue.shade800,
          unselectedItemColor: Colors.grey.shade600,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          type: BottomNavigationBarType.fixed,
          elevation: 10,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Beranda', // Label untuk item beranda.
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group_outlined),
              activeIcon: Icon(Icons.group),
              label: 'Anggota', // Label untuk item anggota.
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons .help_outline),
              activeIcon: Icon(Icons.help),
              label: 'Bantuan', // Label untuk item bantuan.
            ),
          ],
        ),
      ),
    );
  }

  // Navigasi ke layar tertentu.
  void _navigateToScreen(Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  // Mengubah indeks yang dipilih saat item bottom navigation bar ditekan.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Memperbarui indeks yang dipilih.
    });
  }

  // Fungsi untuk logout pengguna.
  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false); // Mengatur status login menjadi false.

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginScreen()), // Mengarahkan kembali ke layar login.
    );
  }
}