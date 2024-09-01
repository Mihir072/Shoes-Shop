import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shoes_shop/Data/add_data.dart';
import 'package:shoes_shop/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Firebase is initialized
  await Firebase.initializeApp();
  await addProducts(); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}
