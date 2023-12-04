import 'package:cinemix/BottomNav.dart';

import 'package:cinemix/Welcome/Login.dart';
import 'package:cinemix/Welcome/Welcome.dart';
import 'package:cinemix/Welcome/Welcome.dart';
import 'package:flutter/material.dart';



import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Welcome(),
    );
  }
}
