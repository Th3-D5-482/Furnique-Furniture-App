import 'package:ciphen/database/descriptiondb.dart';
import 'package:flutter/material.dart';

class DescriptionPage extends StatefulWidget {
  const DescriptionPage({super.key});

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  late Future<List<Map<String, dynamic>>> personFuture;
  final List<String> tabsNames = [
    'Description',
    'Materials',
    'Reviews',
  ];
  int currentTabSelected = 0;

  @override
  void initState() {
    super.initState();
    personFuture = getPersons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: personFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          final personFace = snapshot.data!;
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            'assets/images/banners/ban_chair.png',
                          ),
                          Positioned(
                            top: 40,
                            left: 5,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios,
                                size: 28,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          elevation: 20,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hello World',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(fontWeight: FontWeight.normal),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '\$10',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                    ),
                                    const Spacer(),
                                    Icon(
                                      Icons.indeterminate_check_box_outlined,
                                      size: 32,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '1',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.add_box_outlined,
                                      size: 32,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Row(
                                            children: [
                                              Row(
                                                children:
                                                    List.generate(5, (index) {
                                                  return Icon(
                                                    index < 5
                                                        ? Icons.star
                                                        : Icons.star,
                                                    color: index < 4
                                                        ? Colors.yellow
                                                        : Colors.grey,
                                                    size: 28,
                                                  );
                                                }),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                '4',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              )
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '4 Reviews',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                                  ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              size: 16,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 130,
                                          child: Stack(
                                            children: List.generate(
                                                personFace.length, (index) {
                                              final avatarFaces =
                                                  personFace[index];
                                              if (index == 0) {
                                                return CircleAvatar(
                                                  foregroundImage: NetworkImage(
                                                    avatarFaces['imageUrl'],
                                                  ),
                                                  radius: 20,
                                                );
                                              } else {
                                                return Positioned(
                                                  left: index * 30,
                                                  child: CircleAvatar(
                                                    foregroundImage:
                                                        NetworkImage(
                                                            avatarFaces[
                                                                'imageUrl']),
                                                    radius: 20,
                                                  ),
                                                );
                                              }
                                            }),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                  height: 50,
                                  child: ListView.builder(
                                    itemCount: tabsNames.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final tabItem = tabsNames[index];
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            currentTabSelected = index;
                                          });
                                        },
                                        child: Card(
                                          color: currentTabSelected == index
                                              ? const Color.fromRGBO(
                                                  255, 238, 221, 1)
                                              : null,
                                          elevation: 0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                              tabItem,
                                              style: currentTabSelected == index
                                                  ? Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                      )
                                                  : Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary,
                                                      ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  child: Text(
                                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Similar products',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                SizedBox(
                                  height: 280,
                                  child: ListView.builder(
                                    itemCount: 3,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Stack(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/banners/chair.png',
                                                      width: 150,
                                                    ),
                                                    Positioned(
                                                      top: 1,
                                                      left: 90,
                                                      child: ElevatedButton(
                                                        onPressed: () {},
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          shape:
                                                              const CircleBorder(),
                                                        ),
                                                        child: const Icon(Icons
                                                            .favorite_border_rounded),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const Spacer(),
                                                Text(
                                                  'Hello World',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary,
                                                      ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '\$10',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        side: BorderSide(
                          width: 2,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        padding: const EdgeInsets.all(10),
                      ),
                      child: Icon(
                        Icons.favorite_border_rounded,
                        size: 32,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.all(16),
                        ),
                        child: Text(
                          'Add to bag',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
