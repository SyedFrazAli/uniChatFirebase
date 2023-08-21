// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:unichat/config.dart';
import 'package:unichat/splash_screen.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
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
      home: const SplashScreenView(),
    );
  }
}
