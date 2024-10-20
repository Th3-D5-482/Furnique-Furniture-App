import 'package:ciphen/screens/home_page.dart';
import 'package:ciphen/screens/login_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

final DatabaseReference dbRefUsers = FirebaseDatabase.instance.ref('Users');

void register(
  String emailID,
  String password,
  BuildContext context,
) async {
  String sanitizedEmailID = emailID.replaceAll('.', ',');
  final DatabaseEvent event = await dbRefUsers.child(sanitizedEmailID).once();
  if (event.snapshot.value != null) {
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Account already exists, please login'),
      ),
    );
  } else {
    await dbRefUsers.child(sanitizedEmailID).set({
      'emailID': emailID,
      'password': password,
    });
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Registered Sucessfully'),
      ),
    );
    // ignore: use_build_context_synchronously
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return LoginPage(
          emailID: emailID,
          password: password,
        );
      },
    ));
  }
}

void login(
  String emailID,
  String password,
  BuildContext context,
) async {
  String existingEmailID;
  String existingPassword;
  String sanitizedEmailID = emailID.replaceAll('.', ',');
  final DatabaseEvent event = await dbRefUsers.child(sanitizedEmailID).once();
  if (!event.snapshot.exists) {
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Account doesn't exist, please register"),
      ),
    );
  } else {
    final DataSnapshot snapshot = event.snapshot;
    if (snapshot.exists) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      existingEmailID = values['emailID'];
      existingPassword = values['password'];
      if (existingEmailID == emailID && existingPassword == password) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login Sucessful'),
          ),
        );
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return const HomePage();
        }));
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login Failed'),
          ),
        );
      }
    }
  }
}
