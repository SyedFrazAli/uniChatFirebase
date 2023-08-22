import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unichat/home_screen.dart';
import 'package:unichat/user_data.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSetupScreen extends StatefulWidget {
  final String phoneNumber;

  const ProfileSetupScreen({required this.phoneNumber, Key? key})
      : super(key: key);
  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final TextEditingController _userNameController = TextEditingController();
  String? _profilePictureUrl;

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _profilePictureUrl = pickedImage.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Profile Setup'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Column(
                children: [
                  const Text('Pick Profile Picture',
                  style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.deepPurple),),
                  const SizedBox(height: 10),
                  _profilePictureUrl != null
                      ? CircleAvatar(
                          radius: 58,
                          backgroundColor: Colors.deepPurple,
                            backgroundImage: _profilePictureUrl != null ? FileImage(File(_profilePictureUrl!)) : null,

                          child: Stack(children: [
                            Align(
                              alignment: Alignment.bottomRight,
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.white70,
                                child: Icon(CupertinoIcons.camera),
                              ),
                            ),
                          ]),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _userNameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) async {
                String name = _userNameController.text;
                String phoneNumber = widget.phoneNumber;
                UserData userData = UserData(
                  name: name,
                  phoneNumber: phoneNumber,
                  profilePictureUrl: _profilePictureUrl ?? '',
                );

                await userData.saveUserData();
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String name = _userNameController.text;
                String phoneNumber = widget.phoneNumber;

                await ZIMKit().connectUser(id: phoneNumber, name: name);
                if (!mounted) return;
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
