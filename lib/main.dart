import 'package:ciphen/screens/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project: Ciphen',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(226, 149, 71, 1),
            primary: const Color.fromRGBO(226, 149, 71, 1)),
      ),
      home: const HomePage(),
    );
  }
}
