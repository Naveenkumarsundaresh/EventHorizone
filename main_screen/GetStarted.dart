import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'Choose.dart';


class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 84.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Replace 'assets/images/getstarted.svg' with your actual SVG image path
                SvgPicture.asset(
                  'assets/images/getstarted.svg',
                  width: 250, // Set your desired width
                  height: 250, // Set your desired height
                  fit: BoxFit.contain, // Set the BoxFit property accordingly
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Choose()));
                  },
                  child: Text('Get Started'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
