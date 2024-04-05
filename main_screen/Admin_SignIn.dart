import 'package:eventhorizon/admin/screens/Navigation.dart';
import 'package:eventhorizon/main_screen/Choose.dart';
import 'package:eventhorizon/main_screen/SignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Admin_SignUp.dart';

class AdminSignInScreen extends StatefulWidget {
  const AdminSignInScreen({super.key});

  @override
  State<AdminSignInScreen> createState() => _AdminSignInScreenState();
}

class _AdminSignInScreenState extends State<AdminSignInScreen> {
  @override
  // form key
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // firebase
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  Widget build(BuildContext context) {
    final emailField = Container(
      height: 53,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-z]{2,}$')
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        // onSaved: (value) {
        //   emailEditingController.text = value!;
        // },
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    );
    final passwordField = Container(
      height: 53,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    );
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff6749EC),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                      Choose()));
            },
          ),
        ),
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Color(0xff6749EC),
              child: const Column (
                children: [
                  Text("Welcome Admin",
                    style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        fontFamily: 'Afacad',
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 6,),
                  Text('Create and Manage Events',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontFamily: 'Afacad',
                        fontWeight: FontWeight.normal
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 96),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                  color: Colors.white,
                ),
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(top: 30, left: 30, right: 30),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 12,),
                          Text('Sign In', style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Afacad',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),),
                          SizedBox(height: 27,),
                          Text('Email Id', style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Afacad',
                            fontWeight: FontWeight.w700,
                            color: Color(0xff6749EC),
                          ),),
                          const SizedBox(height: 12,),
                          emailField,
                          SizedBox(height: 30,),
                          const Text('Password', style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Afacad',
                            fontWeight: FontWeight.w700,
                            color: Color(0xff6749EC),
                          ),),
                          const SizedBox(height: 12,),
                          passwordField,
                          SizedBox(height: 40,),
                          GestureDetector(
                            onTap: () {
                              signIn(emailController.text,
                                  passwordController.text);
                            },
                            child: Container(
                              width: 350,
                              height: 53,
                              decoration: BoxDecoration(
                                color: Color(0xff6749EC),
                                // Set your desired button color
                                borderRadius: BorderRadius.circular(
                                    8), // Optional: Set border radius for rounded corners
                              ),
                              child: const Center(
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    // Set your desired text color
                                    fontSize: 18,
                                    fontFamily: 'Afacad',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 35,),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  "Doesn't have an account, ", style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Afacad',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                ),),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const AdminSignUpScreen()));
                                  },
                                  child: const Text(
                                    "SignUp",
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontFamily: 'Afacad',
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff6749EC),
                                    ),
                                  ),
                                )
                              ]),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        )
    );
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        // If login is successful
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Login Successful"),
            duration: const Duration(seconds: 3),
          ),
        );

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => FirstPage()),
        );
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }

        // Display error using SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage ?? "An error occurred"),
            duration: const Duration(seconds: 3),
          ),
        );

        /* print(error.code);*/
      }
    }
  }
}
