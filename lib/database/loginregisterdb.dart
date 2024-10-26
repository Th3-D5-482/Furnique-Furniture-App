import 'package:ciphen/main.dart';
import 'package:ciphen/screens/home_page.dart';
import 'package:ciphen/screens/login_page.dart';
import 'package:ciphen/screens/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void register(
  String emailID,
  String password,
  BuildContext context,
) async {
  try {
    // ignore: unused_local_variable
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailID,
      password: password,
    );
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Registered Sucessfully'),
      ),
    );
    // ignore: use_build_context_synchronously
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return LoginPage(emailID: emailID, password: password);
        },
      ),
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use') {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account alredy exist, Please login'),
        ),
      );
    } else if (e.code == 'weak-password') {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password is too weak'),
        ),
      );
    } else if (e.code == 'invalid-email') {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid EmailID'),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.code),
        ),
      );
    }
  }
}

void login(
  String emailID,
  String password,
  BuildContext context,
) async {
  try {
    // ignore: unused_local_variable
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailID,
      password: password,
    );
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Login Sucessful'),
      ),
    );
    // ignore: use_build_context_synchronously
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return const HomePage();
      },
    ));
    loggedEmailID = emailID;
    loggedPaswword = password;
    // ignore: use_build_context_synchronously
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Account doesn't exist, please login"),
        ),
      );
    } else if (e.code == 'wrong-password') {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Wrong Password"),
        ),
      );
    } else if (e.code == 'invalid-email') {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid EmailID"),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.code),
        ),
      );
    }
  }
}

void signOut(
  BuildContext context,
) async {
  try {
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return const Splash();
      },
    ));
  } catch (e) {
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$e'),
      ),
    );
  }
}
