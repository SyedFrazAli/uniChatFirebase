import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  String name;
  String phoneNumber;
  String profilePictureUrl;

  UserData({
    required this.name,
    required this.phoneNumber,
    required this.profilePictureUrl,
  });

  // Save user data to Firebase and local storage
  Future<void> saveUserData() async {
    // Save to Firebase
    await FirebaseFirestore.instance.collection('users').doc(phoneNumber).set({
      'name': name,
      'phoneNumber': phoneNumber,
      'profilePictureUrl': profilePictureUrl,
    });

    // Save to local storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_data', toString());
  }

  // Load user data from local storage
  static Future<UserData?> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('user_data');
    if (userDataString != null) {
      Map<String, dynamic> userDataMap = json.decode(userDataString);
      return UserData(
        name: userDataMap['name'],
        phoneNumber: userDataMap['phoneNumber'],
        profilePictureUrl: userDataMap['profilePictureUrl'],
      );
    }
    return null;
  }

  // Update user data with new name and phone number
  void updateUserData(String newName, String newPhoneNumber,String newProfile) {
    name = newName;
    phoneNumber = newPhoneNumber;
    profilePictureUrl = newProfile;
  }

  // Convert user data to a map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'profilePictureUrl': profilePictureUrl,
    };
  }

  // Convert user data to a JSON string
  @override
  String toString() {
    return json.encode(toMap());
  }
}
