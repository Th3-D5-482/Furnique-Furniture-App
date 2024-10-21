import 'package:ciphen/database/favoritesdb.dart';
import 'package:ciphen/database/homedb.dart';
import 'package:ciphen/screens/description_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemsLikeProduct extends StatefulWidget {
  const ItemsLikeProduct({super.key});

  @override
  State<ItemsLikeProduct> createState() => _ItemsLikeProductState();
}

class _ItemsLikeProductState extends State<ItemsLikeProduct> {
  late Future<List<Map<String, dynamic>>> furnitureFuture;
  late Stream<List<Map<String, dynamic>>> favoritesStream;
  final formatter = NumberFormat('#,##0');
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    furnitureFuture = getFurnitures();
    favoritesStream = getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: FutureBuilder(
        future: getFurnitures(),
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
            stream: favoritesStream,
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
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Items you might like',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 280,
                      child: ListView.builder(
                        itemCount: furnitures
                            .where(
                                (furniture) => furniture['isPopular'] == true)
                            .toList()
                            .length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final furnituresItem = furnitures
                              .where(
                                  (furniture) => furniture['isPopular'] == true)
                              .toList()[index];
                          isFavorite = favorites.any((favorite) =>
                              favorite['id'] == furnituresItem['id']);
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return DescriptionPage(
                                      id: furnituresItem['id'],
                                      catID: furnituresItem['catID'],
                                      ratings: furnituresItem['ratings'],
                                      imageUrl: furnituresItem['imageUrl'],
                                      furName: furnituresItem['furName'],
                                      price: furnituresItem['price'],
                                      description:
                                          furnituresItem['description'],
                                    );
                                  },
                                ));
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          Image.network(
                                            furnituresItem['imageUrl'],
                                            width: 150,
                                          ),
                                          Positioned(
                                            top: 1,
                                            left: 90,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                addToFavorites(
                                                  furnituresItem['id'],
                                                  furnituresItem['catID'],
                                                  furnituresItem['furName'],
                                                  furnituresItem['imageUrl'],
                                                  furnituresItem['price'],
                                                  furnituresItem['ratings'],
                                                  furnituresItem['description'],
                                                  context,
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                shape: const CircleBorder(),
                                              ),
                                              child: isFavorite
                                                  ? const Icon(
                                                      Icons.favorite_rounded)
                                                  : const Icon(Icons
                                                      .favorite_outline_rounded),
                                            ),
                                          )
                                        ],
                                      ),
                                      const Spacer(),
                                      Text(
                                        furnituresItem['furName'],
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
                                        '\$${formatter.format(furnituresItem['price'])}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      )
                                    ],
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
              );
            },
          );
        },
      ),
    );
  }
}
