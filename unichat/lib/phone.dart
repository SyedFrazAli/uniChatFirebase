import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unichat/otp_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static String verify = "";
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController countryCode = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    countryCode.text = '+92';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                children: [
                  Text(
                    'Welcome! \nto',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Colors.deepPurple),
                  ),
                ],
              ),
              const Row(
                children: [
                  Text(
                    'UNI-Chat',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'You need to Register your phone number before getting started!',
                style: TextStyle(fontSize: 14),
              ),
              Image.asset(
                'assets/sapiens.png',
                width: 300,
                height: 280,
              ),
              const Text(
                'Please enter your Phone Number!',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple),
              ),
              const SizedBox(height: 20),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    const SizedBox(width: 5),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: countryCode,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      '|',
                      style: TextStyle(
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        controller: phoneNumberController,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: '3xxxxxxxxx'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
  onPressed: () async {
    const timeoutDuration = Duration(seconds: 40); // Adjust the timeout duration as needed
    
    String countryCodeValue = countryCode.text.trim();
    String phoneNumberValue = phoneNumberController.text.trim();
    String phoneNumber = countryCodeValue + phoneNumberValue;

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            if (kDebugMode) {
              print('The provided phone number is not valid.');
            }
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          SignUpScreen.verify = verificationId;
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    OtpScreen(phoneNumber: phoneNumber)),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      ).timeout(timeoutDuration); // Add timeout here
    } catch (e) {
      // Handle timeout or other errors here
      if (kDebugMode) {
        print('Operation took too long to complete.');
      }
    }
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.deepPurple,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  child: const Text('Send Code'),
),
 ),
            ],
          ),
        ),
      ),
    );
  }
}
