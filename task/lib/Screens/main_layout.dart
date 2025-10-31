import 'package:flutter/material.dart';
import 'package:task/Screens/home/cs_screen.dart';
import 'package:task/Screens/home/home_screen.dart';
import 'package:task/Screens/home/is_screen.dart';
import 'package:task/Screens/home/it_screen.dart';
import 'package:task/Screens/home/ts_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    ItScreen(),
    CsScreen(),
    IsScreen(),
    TsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Departments',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.computer), label: 'IT'),
          BottomNavigationBarItem(icon: Icon(Icons.code), label: 'CS'),
          BottomNavigationBarItem(icon: Icon(Icons.storage), label: 'IS'),
          BottomNavigationBarItem(icon: Icon(Icons.memory), label: 'TS'),
        ],
      ),
    );
  }
}
