import 'package:flutter/material.dart';

class settings extends StatefulWidget {
  const settings({super.key});

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65.0), // Adjust the height as needed
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xff6749EC),
            title: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                "Settings",
                style: const TextStyle(fontSize: 20, fontFamily: 'Afacad', fontWeight: FontWeight.bold),
              ),
            ),
            centerTitle: true,
          ),
        ),
      ),
    );
  }
}
