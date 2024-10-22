import 'package:ciphen/firebase_options.dart';
import 'package:ciphen/screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

String? loggedEmailID;
String? loggedPaswword;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project: Ciphen',
      theme: ThemeData(
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(
            fontSize: 20,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 255, 255, 1),
          primary: const Color.fromRGBO(226, 149, 71, 1),
          secondary: const Color.fromRGBO(170, 170, 170, 1),
          tertiary: const Color.fromRGBO(226, 71, 71, 1),
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Color.fromRGBO(222, 222, 222, 1),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Color.fromRGBO(222, 222, 222, 1),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          prefixIconColor: Theme.of(context).colorScheme.primary,
        ),
      ),
      home: const Splash(),
    );
  }
}
