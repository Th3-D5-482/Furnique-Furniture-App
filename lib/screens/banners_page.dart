import 'package:ciphen/constants/banners_cat.dart';
import 'package:ciphen/database/bannersdb.dart';
import 'package:ciphen/screens/banners_description_page.dart';
import 'package:flutter/material.dart';

class BannersPage extends StatefulWidget {
  final int id;
  final String text1;
  final String text3;
  const BannersPage({
    super.key,
    required this.id,
    required this.text1,
    required this.text3,
  });

  @override
  State<BannersPage> createState() => _BannersPageState();
}

class _BannersPageState extends State<BannersPage> {
  late Future<List<Map<String, dynamic>>> bannersFuture;

  @override
  void initState() {
    super.initState();
    bannersFuture = getBannersData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: bannersFuture,
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
          final banners = snapshot.data!;
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 28,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        widget.text1,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.text3,
                        style: const TextStyle(fontSize: 36),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'off',
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: GridView.builder(
                        itemCount: banners
                            .where((banner) => banner['banID'] == widget.id)
                            .toList()
                            .length,
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.57,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final bannersItems = banners
                              .where((banner) => banner['banID'] == widget.id)
                              .toList()[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return BannersDescriptionPage(
                                    banID: bannersItems['banID'],
                                    description: bannersItems['description'],
                                    furName: bannersItems['furName'],
                                    id: bannersItems['id'],
                                    imageUrl: bannersItems['imageUrl'],
                                    price: bannersItems['price'],
                                    ratings: bannersItems['ratings'],
                                  );
                                },
                              ));
                            },
                            child: Card(
                              child: BannersCat(
                                banID: bannersItems['banID'],
                                furName: bannersItems['furName'],
                                price: bannersItems['price'],
                                imageUrl: bannersItems['imageUrl'],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
