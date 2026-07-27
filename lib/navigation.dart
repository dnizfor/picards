import 'package:flutter/material.dart';
import 'package:picards/screens/deck_list_screen.dart';
import 'package:picards/screens/feed_screen.dart';
import 'package:picards/screens/config_screen.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currenIndex = 0;
  List<Widget> body = const [DeckListScreen(), FeedScreen(), ConfigScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF121212),
        selectedItemColor: Color(0xFF2979FF),
        unselectedItemColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currenIndex,
        onTap: (int newIndex) => setState(() => _currenIndex = newIndex),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.copy), label: 'home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_fire_department),
            label: 'profile',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
        ],
      ),
      body: SafeArea(child: body[_currenIndex]),
    );
  }
}
