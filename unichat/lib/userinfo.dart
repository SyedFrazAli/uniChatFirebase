import 'package:flutter/material.dart';
import 'package:unichat/user_data.dart'; // Import the UserData class
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}
class _UserInfoScreenState extends State<UserInfoScreen> {
  UserData? userData; // Change to nullable UserData

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    String phoneNumber = FirebaseAuth.instance.currentUser?.phoneNumber ?? '';
    
    DocumentSnapshot docSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(phoneNumber).get();

    Map<String, dynamic> userDataMap = docSnapshot.data() as Map<String, dynamic>;

    userData = await UserData.loadUserData() ??
        UserData(
          name: userDataMap['name'] ?? 'Unknown',
          phoneNumber: phoneNumber,
          profilePictureUrl: userDataMap['profilePictureUrl'] ?? '',
        );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('User Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${userData?.name ?? 'Loading...'}'), // Use ?. operator
            const SizedBox(height: 10),
            Text('Phone Number: ${userData?.phoneNumber ?? 'Loading...'}'),
            const SizedBox(height: 10),
            Text('Profile Picture URL: ${userData?.profilePictureUrl ?? 'Loading...'}'),
          ],
        ),
      ),
    );
  }
}
