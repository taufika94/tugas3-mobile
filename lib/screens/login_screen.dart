import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';
import 'dart:math';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _opacityAnimation,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: _buildLogo(),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _opacityAnimation,
                      child: _buildTitle(),
                    ),
                  ),
                  SizedBox(height: 40),
                  SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _opacityAnimation,
                      child: _buildGlassCard(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return SizedBox.expand(
      child: CustomPaint(
        painter: _CustomBackgroundPainter(),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(-5, -5),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: Offset(5, 5),
          ),
        ],
      ),
      child: Icon(Icons.account_circle, size: 80, color: const Color.fromARGB(255, 255, 255, 255)),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Text(
          'Selamat Datang',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 8,
                color: Colors.black26,
                offset: Offset(2, 2),
              )
            ],
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Masuk untuk melanjutkan',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildGlassCard () {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 53, 138, 199).withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white),
          ),
          child: Column(
            children: [
              _buildTextField(
                controller: _usernameController,
                label: 'Username',
                icon: Icons.person_outline,
              ),
              SizedBox(height: 20),
              _buildTextField(
                controller: _passwordController,
                label: 'Password',
                icon: Icons.lock_outline,
                obscure: _obscurePassword,
                isPassword: true,
              ),
              SizedBox(height: 30),
              _buildLoginButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscure = false,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(icon, color: Colors.white),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  obscure ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
              )
              
            : null,
        filled: true,
        fillColor: Colors.white.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue.shade300, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade800, const Color.fromARGB(255, 6, 23, 38)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: _isLoading ? 0 : 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: _isLoading ? null : _login,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedOpacity(
                opacity: _isLoading ? 0 : 1,
                duration: Duration(milliseconds: 200),
                child: Text(
                  'MASUK',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              if (_isLoading)
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 3,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      _showError('Username dan password dibutuhkan');
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(Duration(seconds: 2));

    if (_usernameController.text != 'admin' ||
        _passwordController.text != 'password') {
      setState(() => _isLoading = false);
      _showError('Kredensial tidak valid');
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('username', _usernameController.text);

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition (opacity: animation,
            child: child,
          );
        },
        transitionDuration: Duration(milliseconds: 500),
      ),
    );
  }

  void _showError(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red.shade400,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(20),
      duration: Duration(seconds: 2),
      action: SnackBarAction(
        label: 'OK',
        textColor: Colors.white,
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}

class _CustomBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    final paint = Paint();

    // Membuat gradient linear
    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.blue.shade100, // Warna awal yang lebih terang
        Colors.blue.shade400,
        Colors.blue.shade700,
        Colors.blue.shade900, // Menambahkan warna biru tua
      ],
      stops: [0.0, 0.3, 0.6, 1.0], // Mengatur sebaran warna
    );

    paint.shader = gradient.createShader(Rect.fromLTWH(0, 0, width, height));
    paint.style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), paint);

    // Tambahkan elemen-elemen abstrak di atas gradient
    final paint2 = Paint()..style = PaintingStyle.fill;

    // Bentuk abstrak kuning di kanan bawah
    paint2.color = Color(0xFFFFF9C4).withOpacity(0.7);
    Path path1 = Path();
    path1.moveTo(width * 0.6, height * 0.8);
    path1.quadraticBezierTo(width * 0.9, height * 0.95, width, height * 0.7);
    path1.lineTo(width, height);
    path1.lineTo(width * 0.5, height);
    path1.close();
    canvas.drawPath(path1, paint2);

    // Bentuk abstrak cyan di kiri atas
    paint2.color = Color(0xFFE0F7FA).withOpacity(0.6);
    Path path2 = Path();
    path2.moveTo(0, height * 0.2);
    path2.quadraticBezierTo(width * 0.1, height * 0.05, width * 0.3, 0);
    path2.lineTo(0, 0);
    path2.close();
    canvas.drawPath(path2, paint2);

    // Lingkaran-lingkaran kecil dengan warna berbeda
    paint2.color =  Colors.yellow;
    canvas.drawCircle(Offset(width * 0.15, height * 0.1), 15, paint2);
    paint2.color = Colors.cyan.shade200.withOpacity(0.5);
    canvas.drawCircle(Offset(width * 0.85, height * 0.85), 10, paint2);
    paint2.color = const Color.fromARGB(255, 255, 0, 0).withOpacity(0.5);
    canvas.drawCircle(Offset(width * 0.9, height * 0.15), 20, paint2);
    paint2.color = const Color.fromARGB(255, 0, 255, 72).withOpacity(0.5);
    canvas.drawCircle(Offset(width * 0.05, height * 0.95), 12, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}