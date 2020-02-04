import 'package:flutter/material.dart';
import 'package:magiquery/pages/favorites.dart';
import 'package:magiquery/pages/home.dart';

class NavTabBar extends StatefulWidget {
  @override
  _NavTabBarState createState() => _NavTabBarState();
}

class _NavTabBarState extends State<NavTabBar> {
  List<Widget> _pages = [Home(), Favorites()];
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.yellow,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            title: Text('Favorites'),
          ),
        ],
        onTap: _selectPage,
      ),
    );
  }
}
