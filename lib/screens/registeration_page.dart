import 'package:ciphen/database/loginregisterdb.dart';
import 'package:ciphen/screens/login_page.dart';
import 'package:flutter/material.dart';

class RegisterationPage extends StatefulWidget {
  const RegisterationPage({super.key});

  @override
  State<RegisterationPage> createState() => _RegisterationPageState();
}

class _RegisterationPageState extends State<RegisterationPage> {
  TextEditingController emailID = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isShowPassword = false;

  @override
  void initState() {
    super.initState();
    emailID = TextEditingController(text: 'th3_d5_482@gmail.com');
    password = TextEditingController(text: '12345678');
  }

  @override
  void dispose() {
    super.dispose();
    emailID.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return const LoginPage(
                                  emailID: '',
                                  password: '',
                                );
                              },
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 28,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Registeration',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Column(
                          children: [
                            const CircleAvatar(
                              foregroundImage: AssetImage(
                                  'assets/images/random/app_icon.png'),
                              radius: 110,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'EmailID:',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  controller: emailID,
                                  decoration: InputDecoration(
                                    border: Theme.of(context)
                                        .inputDecorationTheme
                                        .enabledBorder,
                                    prefixIcon: const Icon(
                                      Icons.email_rounded,
                                      size: 32,
                                    ),
                                    prefixIconColor:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Password: ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  controller: password,
                                  decoration: InputDecoration(
                                    border: Theme.of(context)
                                        .inputDecorationTheme
                                        .enabledBorder,
                                    prefixIcon: const Icon(
                                      Icons.password_rounded,
                                      size: 32,
                                    ),
                                    prefixIconColor:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  obscureText: isShowPassword ? false : true,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  keyboardType: TextInputType.visiblePassword,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                        value: isShowPassword,
                                        onChanged: (value) {
                                          setState(() {
                                            isShowPassword = value!;
                                          });
                                        }),
                                    Text(
                                      'Show password',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.normal,
                                          ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 80,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (emailID.text.isEmpty ||
                                      password.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Please enter your Credentials'),
                                      ),
                                    );
                                  } else if (password.text.length < 8) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Passwords must be greater than 7 characters long'),
                                      ),
                                    );
                                  } else {
                                    register(
                                      emailID.text,
                                      password.text,
                                      context,
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.all(16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Text(
                                  'Register',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const LoginPage(
                                        emailID: '',
                                        password: '',
                                      );
                                    },
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Text(
                                "Have an account? SignIn",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.normal,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
