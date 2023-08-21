import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unichat/home_screen.dart';
import 'package:unichat/phone.dart';


class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

// ignore: camel_case_types
class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), (() {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const AuthChecker()));
    }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/uni.jpg'),
              )),
            ),
          ),
        ]),
    );
  }
}
class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator if the auth state is still loading
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.deepPurple,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          // Handle errors
          return const Scaffold(
            body: Center(
              child: Text(
                "An error occurred. Please try again later.",
                style: TextStyle(color: Colors.red),
              ),
            ),
          );
        } else {
          // Check if the user is logged in or not
          final user = snapshot.data;
          if (user != null) {
            // If user is logged in, show the HomeScreen
            return const HomeScreen();
          } else {
            // If user is not logged in, show the SignUpScreen
            return const SignUpScreen();
          }
        }
      },
    );
  }
}
