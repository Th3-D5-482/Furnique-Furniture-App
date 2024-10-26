import 'package:ciphen/database/loginregisterdb.dart';
import 'package:ciphen/screens/home_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Card(
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
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return const HomePage();
                            },
                          ));
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
                        'About Me',
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
                                'assets/images/persons/th3_d5_482.png',
                              ),
                              radius: 100,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Th3_D5_482',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Text(
                                    "I'm an innovative software developer passionate about creating efficient, user-friendly applications. With a strong background in various programming languages, I excel at solving complex problems and turning ideas into reality. I'm committed to continuous learning and delivering top-notch solutions that exceed expectations.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.normal,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 110,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  signOut(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  padding: const EdgeInsets.all(16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Text(
                                  'Sign Out',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Colors.white,
                                      ),
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
