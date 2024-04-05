import 'package:flutter/material.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
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
                "Home",
                style: const TextStyle(fontSize: 20, fontFamily: 'Afacad', fontWeight: FontWeight.bold),
              ),
            ),
            centerTitle: true,
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.event_busy,
                size: 100,
                color: Colors.grey,
              ),
              SizedBox(height: 20),
              Text(
                'You have not registered for any event yet.',
                style: TextStyle(
                color: Colors.black,
                fontFamily: 'Afacad',
                fontSize: 18,
                fontWeight:
                FontWeight.w500,
              ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


