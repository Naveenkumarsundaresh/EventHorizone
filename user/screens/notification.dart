import 'package:flutter/material.dart';

class notification extends StatefulWidget {
  const notification({super.key});

  @override
  State<notification> createState() => _notificationState();
}

class _notificationState extends State<notification> {
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
                "Notifications",
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
