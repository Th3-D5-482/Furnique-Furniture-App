import 'package:ciphen/database/favoritesdb.dart';
import 'package:ciphen/database/homedb.dart';
import 'package:ciphen/screens/description_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SimilarProducts extends StatefulWidget {
  final int id;
  final int catID;
  final String furName;
  final String imageUrl;
  final int price;
  final double ratings;
  final String description;
  const SimilarProducts({
    super.key,
    required this.id,
    required this.catID,
    required this.furName,
    required this.imageUrl,
    required this.price,
    required this.ratings,
    required this.description,
  });

  @override
  State<SimilarProducts> createState() => _SimilarProductsState();
}

class _SimilarProductsState extends State<SimilarProducts> {
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
    return FutureBuilder(
      future: furnitureFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
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
            return SizedBox(
              height: 280,
              child: ListView.builder(
                itemCount: furnitures
                    .where((furniture) => furniture['catID'] == widget.catID)
                    .where((furniture) => furniture['id'] != widget.id)
                    .toList()
                    .length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final furnituresItem = furnitures
                      .where((furniture) => furniture['catID'] == widget.catID)
                      .where((furniture) => furniture['id'] != widget.id)
                      .toList()[index];
                  isFavorite = favorites.any(
                      (favorite) => favorite['id'] == furnituresItem['id']);
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
                              description: furnituresItem['description'],
                            );
                          },
                        ));
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                          ? const Icon(Icons.favorite_rounded)
                                          : const Icon(
                                              Icons.favorite_border_rounded,
                                            ),
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
                                style: Theme.of(context).textTheme.titleLarge,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
