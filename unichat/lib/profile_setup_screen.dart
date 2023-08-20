// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:unichat/home_screen.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class ProfileSetupScreen extends StatefulWidget {
  final String phoneNumber;

 const ProfileSetupScreen({required this.phoneNumber, Key? key})
      : super(key: key);
  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final TextEditingController _userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Setup'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _userNameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String Name = _userNameController.text;
                String phoneNumber = widget.phoneNumber;

                await ZIMKit().connectUser(id: phoneNumber, name: Name);
                if (!mounted) return;
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const HomeScreen()));
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

