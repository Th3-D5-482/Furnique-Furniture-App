import 'package:flutter/material.dart';

class DescriptionPage extends StatefulWidget {
  const DescriptionPage({super.key});

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  final List<String> avatarImages = [
    'assets/images/faces/face1.png',
    'assets/images/faces/face2.png',
    'assets/images/faces/face3.png',
    'assets/images/faces/face4.png',
  ];
  final List<String> tabsNames = [
    'Description',
    'Materials',
    'Reviews',
  ];
  int currentTabSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.indeterminate_check_box_outlined,
                          size: 32,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '1',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.add_box_outlined,
                          size: 32,
                          color: Theme.of(context).colorScheme.primary,
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
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Row(
                                    children: List.generate(5, (index) {
                                      return Icon(
                                        index < 5 ? Icons.star : Icons.star,
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
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
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
                                  color:
                                      Theme.of(context).colorScheme.secondary,
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
                                children:
                                    List.generate(avatarImages.length, (index) {
                                  final avatarFaces = avatarImages[index];
                                  if (index == 0) {
                                    return CircleAvatar(
                                      foregroundImage: AssetImage(avatarFaces),
                                      radius: 20,
                                    );
                                  } else {
                                    return Positioned(
                                      left: index * 30,
                                      child: CircleAvatar(
                                        foregroundImage:
                                            AssetImage(avatarFaces),
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
                                  ? const Color.fromRGBO(255, 238, 221, 1)
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
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
