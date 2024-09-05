import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Profil'),
            decoration: BoxDecoration(
              color: Colors.grey[400],
            ),
          ),
          ListTile(
            title: Text('Giriş Yap'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Kategoriler'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          // Diğer menü öğeleri
        ],
      ),
    );
  }
}
