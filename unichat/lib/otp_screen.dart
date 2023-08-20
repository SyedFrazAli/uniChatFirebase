// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinput/pinput.dart';
import 'package:unichat/phone.dart';
import 'package:unichat/profile_setup_screen.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
   const OtpScreen({super.key, required this.phoneNumber,});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(71, 30, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(218, 83, 245, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(159, 57, 226, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(174, 0, 255, 0.226),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.purple.shade600,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Verify OTP code',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple.shade600),
              ),
              const SizedBox(height: 20),
              const Text(
                'OTP code has been sent to your Phone',
                style: TextStyle(fontSize: 14),
              ),
              Image.asset(
                'assets/p1.png',
                width: 300,
                height: 280,
              ),
              Text(
                'Please enter your code!',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple.shade600),
              ),
              const SizedBox(height: 20),
              Pinput(
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                length: 6,
                onChanged: (value) {},
                showCursor: true,
                controller: _otpController,
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
  String otpCode = _otpController.text.trim();
  String verificationId = SignUpScreen.verify;
  String phoneNumber = widget.phoneNumber;// Get the phone number from the controller

  try {
    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otpCode,
    );

    // Sign the user in (or link) with the credential
    await _auth.signInWithCredential(credential);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ProfileSetupScreen(phoneNumber: phoneNumber)), // Pass the phoneNumber here
    );
  } catch (e) {
    if (kDebugMode) {
      print("Wrong OTP code, please try again!");
    }
  }
},

                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple.shade600,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text('Verify Phone Number'),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUpScreen()),
                    );
                  },
                  child: Text(
                    'Edit Phone Number ?',
                    style: TextStyle(color: Colors.purple.shade600),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
