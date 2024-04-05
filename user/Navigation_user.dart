import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eventhorizon/user/screens/settings.dart';
import 'package:flutter/material.dart';
import 'screens/ExploreEvent.dart';
import 'screens/notification.dart';
import 'screens/UserHome.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  final List _pages = [UserHome(), ExploreEvent(), notification(), settings()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Set transparency for Scaffold
      body: Stack(
        children: [
          _pages[_selectIndex], // Your content
          Align(
            alignment: Alignment.bottomCenter,
            child: CurvedNavigationBar(
              height: 65, // Adjust the height as needed
              color: Color(0xff6749EC),
              backgroundColor: Colors.transparent, // Set transparent background
              animationDuration: Duration(milliseconds: 400),
              onTap: _navigateBottomBar,
              items: [
                Icon(Icons.home_rounded, color: Colors.white),
                Icon(Icons.event_available, color: Colors.white),
                Icon(Icons.notifications_active, color: Colors.white),
                Icon(Icons.settings, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
