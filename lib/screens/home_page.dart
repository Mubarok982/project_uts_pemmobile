import 'package:flutter/material.dart';
import 'calculator_page.dart';
import 'add_number_page.dart';
import 'menu3_page.dart';
import 'menu4_page.dart';
import 'dashboard_page.dart'; 

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  final List<Widget> _pages = [
    const DashboardPage(), 
    const CalculatorPage(),
    const AddNumberPage(),
    const Menu3Page(),
    const Menu4Page(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu Utama')),
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'Kalkulator'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Tambah Angka'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu 3'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Menu 4'),
        ],
      ),
    );
  }
}
