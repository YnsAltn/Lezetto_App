import 'package:flutter/material.dart';
import 'package:flutter_demo/screens/favorite_page/favorite_page.dart';
import 'package:flutter_demo/screens/kitchen_page.dart';
import 'package:flutter_demo/screens/search_page/search_page.dart';
import 'package:flutter_demo/screens/shopping_page/shopping_page.dart';
import '../components/appBar.dart';
import '../components/bottomNavBar.dart';
import '../components/sideBar.dart';
import 'home_page/home_page.dart';

class MainTemplate extends StatefulWidget {
  @override
  _MainTemplateState createState() => _MainTemplateState();
}

class _MainTemplateState extends State<MainTemplate> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    KitchenPage(),
    SearchPage(),
    FavoritePage(),
    ShoppingCartPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: SideBar(),
      body: Stack(
        children: [
          _pages[_selectedIndex],
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavBar(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            ),
          ),
        ],
      ),
    );
  }
}
