import 'package:ciphen/constants/popular.dart';
import 'package:ciphen/database/favoritesdb.dart';
import 'package:ciphen/database/homedb.dart';
import 'package:ciphen/screens/description_page.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  final int id;
  final String catName;
  const CategoryPage({
    super.key,
    required this.id,
    required this.catName,
  });

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late Future<List<Map<String, dynamic>>> funitureFuture;
  late Stream<List<Map<String, dynamic>>> favoriteStream;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    funitureFuture = getFurnitures();
    favoriteStream = getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: funitureFuture,
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
                      Text(
                        'Category: ${widget.catName}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: GridView.builder(
                          itemCount: furnitures
                              .where((furniture) =>
                                  furniture['catID'] == widget.id)
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
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final furnitureItem = furnitures
                                .where((furniture) =>
                                    furniture['catID'] == widget.id)
                                .toList()[index];
                            isFavorite = favorites.any((favorite) =>
                                favorite['id'] == furnitureItem['id']);
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return DescriptionPage(
                                      id: furnitureItem['id'],
                                      catID: furnitureItem['catID'],
                                      ratings: furnitureItem['ratings'],
                                      imageUrl: furnitureItem['imageUrl'],
                                      furName: furnitureItem['furName'],
                                      price: furnitureItem['price'],
                                      description: furnitureItem['description'],
                                      materials: furnitureItem['materials'],
                                    );
                                  },
                                ));
                              },
                              child: Card(
                                child: Popular(
                                  id: furnitureItem['id'],
                                  catID: furnitureItem['catID'],
                                  imageUrl: furnitureItem['imageUrl'],
                                  furName: furnitureItem['furName'],
                                  price: furnitureItem['price'],
                                  ratings: furnitureItem['ratings'],
                                  description: furnitureItem['description'],
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
