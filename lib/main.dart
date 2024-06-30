import 'package:flutter/material.dart';
import 'datasource.dart';
import 'pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF202C3B)),
        primaryColor: primaryBlack,
        fontFamily: 'Circular',
      ),
      home: const Home(),
    );
  }
}