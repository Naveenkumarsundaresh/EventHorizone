import 'package:eventhorizon/main_screen/Admin_SignIn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SignIn.dart';

class Choose extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                // Navigate to user screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              },
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/user.png',
                        width: 120, // Set the width to twice the radius to ensure a circular fit
                        height: 120, // Set the height to twice the radius to ensure a circular fit
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 16,),
              Text("User",
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff6749EC),
                    fontFamily: 'Afacad',
                    fontWeight: FontWeight.bold
                ),) // Add your desired text here
                ],
              ),
            ),
            SizedBox(height: 100),
            InkWell(
              onTap: () {
                // Navigate to user screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminSignInScreen()),
                );
              },
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/admin.png',
                        width: 120, // Set the width to twice the radius to ensure a circular fit
                        height: 120, // Set the height to twice the radius to ensure a circular fit
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 16,),
                  Text("Admin",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff6749EC),
                        fontFamily: 'Afacad',
                        fontWeight: FontWeight.bold
                    ),) // Add your desired text here
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
