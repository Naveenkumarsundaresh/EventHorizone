import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventhorizon/main_screen/Admin_SignUp.dart';
import 'package:eventhorizon/main_screen/SignIn.dart';
import 'package:eventhorizon/admin/screens/Navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/userModel.dart';
import 'Choose.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  // our form key
  final _formKey = GlobalKey<FormState>();

  // editing Controller
  final userNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();

  Widget build(BuildContext context) {
    final userNameField = Container(
      height: 53,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        autofocus: false,
        controller: userNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("UserName cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Username(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          userNameEditingController.text = value!;
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    );
    final emailField = Container(
      height: 53,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        autofocus: false,
        controller: emailEditingController,
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
        controller: passwordEditingController,
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
          passwordEditingController.text = value!;
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
              child: const Column(
                children: [
                  Text(
                    "Let's Get Started",
                    style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        fontFamily: 'Afacad',
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    'Create an Account',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontFamily: 'Afacad',
                        fontWeight: FontWeight.normal),
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
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Afacad',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 27,
                          ),
                          Text(
                            'Username',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Afacad',
                              fontWeight: FontWeight.w700,
                              color: Color(0xff6749EC),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          userNameField,
                          SizedBox(
                            height: 30,
                          ),
                          const Text(
                            'Email id',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Afacad',
                              fontWeight: FontWeight.w700,
                              color: Color(0xff6749EC),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          emailField,
                          SizedBox(
                            height: 30,
                          ),
                          const Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Afacad',
                              fontWeight: FontWeight.w700,
                              color: Color(0xff6749EC),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          passwordField,
                          const SizedBox(
                            height: 12,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                signUp(
                                  emailEditingController.text,
                                  passwordEditingController.text,
                                );
                              }
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
                                  'Sign up',
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
                          SizedBox(
                            height: 35,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  "Already have an account, ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Afacad',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignInScreen()));
                                  },
                                  child: const Text(
                                    "SignIn",
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontFamily: 'Afacad',
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff6749EC),
                                    ),
                                  ),
                                )
                              ]),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          // Display error using SnackBar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e!.message ?? "An error occurred"),
              duration: const Duration(seconds: 3),
            ),
          );
        });
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
        print(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.userName = userNameEditingController.text;

    try {
      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .set(userModel.toMap());

      // Display success message using SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Account created successfully :)"),
          duration: const Duration(seconds: 3),
        ),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => FirstPage()),
        (route) => false,
      );
    } catch (e) {
      print("Error posting data to Firestore: $e");

      // Display error message using SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error creating account. Please try again later."),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}
