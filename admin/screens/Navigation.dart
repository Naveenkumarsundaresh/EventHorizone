import 'package:eventhorizon/admin/screens/HomeScreen.dart';
import 'package:eventhorizon/admin/screens/ManageUsers.dart';
import 'package:eventhorizon/admin/screens/AddEvent.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  //current page to display
  int _selectIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  final List _pages = [HomeScreen(), AddEvent(),  ManageUsers()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_selectIndex],
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 20,
          currentIndex: _selectIndex,
          onTap: _navigateBottomBar,
          selectedItemColor: Color(0xff6749EC),
          // Set the color for the selected item
          unselectedItemColor: Colors.grey,
          // Set the color for unselected items
          iconSize: 28,
          items: [
            //home
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),

            //events
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: 'Add',
            ),

            //profile
            BottomNavigationBarItem(
              icon: Icon(Icons.person_3_rounded),
              label: 'Profile',
            ),
          ],
        ));
  }
}
