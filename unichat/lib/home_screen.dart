import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:unichat/phone.dart';
import 'package:zego_zimkit/compnents/compnents.dart';
import 'package:zego_zimkit/pages/pages.dart';
import 'chat_popup_option.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Handle the successful sign-out, e.g., navigate back to the login screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignUpScreen()),
      ); // Navigate back to the previous screen (LoginScreen)
    } catch (e) {
      // Handle sign-out errors, if any
      if (kDebugMode) {
        print('Error signing out: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: const [ChatPopupOption()],
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child:
                Image.asset(
                  'assets/icon/icon1.png', // Adjust the path as needed
                  width: 30,
                  height: 30,
                ),
            ),
                SizedBox(
                  width: 10,
                ),
                const Text("UNI-Chat App"),
              
            
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          _chatListSection(),
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: _signOut,
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
        ),
        child: const Text('Sign Out'),
      ),
    );
  }

  Widget _chatListSection() {
    return Expanded(
      child: ZIMKitConversationListView(
        onPressed: (context, conversation, defaultAction) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ZIMKitMessageListPage(
                conversationID: conversation.id,
                conversationType: conversation.type,
              ),
            ),
          );
        },
      ),
    );
  }
}
