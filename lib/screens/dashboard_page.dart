import 'package:flutter/material.dart';
import 'calculator_page.dart';
import 'add_number_page.dart';
import 'menu3_page.dart';
import 'menu4_page.dart';
import 'login_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E5F5), // lembut ungu muda
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text(
              'Selamat Datang di Aplikasi Sederhana!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // 2 kolom
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildMenuCard(
                    context,
                    title: 'Kalkulator',
                    icon: Icons.calculate,
                    color: Colors.deepPurpleAccent,
                    page: const CalculatorPage(),
                  ),
                  _buildMenuCard(
                    context,
                    title: 'Tambah Angka',
                    icon: Icons.add_circle_outline,
                    color: Colors.purple,
                    page: const AddNumberPage(),
                  ),
                  _buildMenuCard(
                    context,
                    title: 'Menu 3',
                    icon: Icons.menu,
                    color: Colors.purpleAccent,
                    page: const Menu3Page(),
                  ),
                  _buildMenuCard(
                    context,
                    title: 'Menu 4',
                    icon: Icons.settings,
                    color: Colors.deepPurple,
                    page: const Menu4Page(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                  );
                },
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context,
      {required String title,
      required IconData icon,
      required Color color,
      required Widget page}) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
        color: color, // ubah warna card sesuai parameter
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 48),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white, // teks putih agar kontras
              ),
            ),
          ],
        ),
      ),
    );
  }
}
