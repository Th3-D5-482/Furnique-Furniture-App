import 'package:ciphen/constants/banners_cat.dart';
import 'package:ciphen/database/favoritesdb.dart';
import 'package:ciphen/database/homedb.dart';
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
  late Future<List<Map<String, dynamic>>> furnituresFuture;
  late Stream<List<Map<String, dynamic>>> favoriteStream;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    furnituresFuture = getFurnitures();
    favoriteStream = getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: furnituresFuture,
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
          final furnitures = snapshot.data!;
          return StreamBuilder(
            stream: favoriteStream,
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
              final favorites = snapshot.data!;
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
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: GridView.builder(
                          itemCount: furnitures
                              .where(
                                  (banner) => banner['catID'] == widget.id + 3)
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
                            final furnituresItems = furnitures
                                .where((furniture) =>
                                    furniture['catID'] == widget.id + 3)
                                .toList()[index];
                            isFavorite = favorites.any((favorite) =>
                                favorite['id'] == furnituresItems['id']);
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return BannersDescriptionPage(
                                      id: furnituresItems['id'],
                                      catID: furnituresItems['catID'],
                                      ratings: furnituresItems['ratings'],
                                      imageUrl: furnituresItems['imageUrl'],
                                      furName: furnituresItems['furName'],
                                      price: furnituresItems['price'],
                                      description:
                                          furnituresItems['description'],
                                      materials: furnituresItems['materials'],
                                    );
                                  },
                                ));
                              },
                              child: Card(
                                child: BannersCat(
                                  id: furnituresItems['id'],
                                  catID: furnituresItems['catID'],
                                  furName: furnituresItems['furName'],
                                  price: furnituresItems['price'],
                                  imageUrl: furnituresItems['imageUrl'],
                                  description: furnituresItems['description'],
                                  ratings: furnituresItems['ratings'],
                                  isFavorite: isFavorite,
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
