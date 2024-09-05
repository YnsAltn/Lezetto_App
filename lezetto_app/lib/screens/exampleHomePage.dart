import 'package:flutter/material.dart';
import 'package:flutter_demo/screens/recipes_page.dart';
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
    ListPage(),
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
