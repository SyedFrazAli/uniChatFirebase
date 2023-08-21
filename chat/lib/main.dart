// ignore_for_file: camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unichat/config.dart';
import 'package:unichat/home_screen.dart';
import 'package:unichat/phone.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await DataManagement.loadEnvFile;
  final appId = DataManagement.getSecretData(StoredString.appId);
  final appSignKey = DataManagement.getSecretData(StoredString.appSignKey);
  await ZIMKit().init(
    appID: int.parse(appId),
    appSign: appSignKey,
  );
  runApp(const unichat());
}

class unichat extends StatefulWidget {
  const unichat({super.key});

  @override
  State<unichat> createState() => _unichatState();
}

class _unichatState extends State<unichat> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Uni Chat",
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: 1.0,
        ),
        child: child!,
      ),
      home: const AuthChecker(),
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
