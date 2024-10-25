import 'package:ciphen/screens/home_page.dart';
import 'package:ciphen/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      User? users = FirebaseAuth.instance.currentUser;
      if (users != null) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return const HomePage(
              emailID: '',
              password: '',
            );
          },
        ));
      } else {
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return const LoginPage(
                emailID: 'th3_d5_482@gmail.com',
                password: '12345678',
              );
            },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                foregroundImage:
                    AssetImage('assets/images/random/app_icon.png'),
                radius: 110,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Furnique',
                style: TextStyle(
                  fontSize: 32,
                ),
              ),
              Text(
                'By: Th3_D5_482',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
