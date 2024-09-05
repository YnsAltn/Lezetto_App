import 'package:flutter/material.dart';
import '../components/appBar.dart';
import '../components/bottomNavBar.dart';
import '../components/sideBar.dart';
import 'mainScreen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    MainScreen(), // MainScreen burada çağrılır
    Center(child: Text('Search Page')),
    Center(child: Text('Kitchen Page')),
    Center(child: Text('List Page')),
    Center(child: Text('Recipes Page')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(), // AppBar'ı buraya ekleyin
      drawer: SideBar(), // Yan menüyü burada tanımlayın
      body: _pages[_selectedIndex], // Sayfa içeriği
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
