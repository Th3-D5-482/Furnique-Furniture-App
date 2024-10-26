import 'package:ciphen/constants/favorite_items.dart';
import 'package:ciphen/constants/items_like_product.dart';
import 'package:ciphen/database/favoritesdb.dart';
import 'package:ciphen/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FavoritePage extends StatefulWidget {
  final int currentPage;
  const FavoritePage({
    super.key,
    required this.currentPage,
  });

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late Stream<List<Map<String, dynamic>>> favoriteStream;
  final formatter = NumberFormat('#,##0');

  @override
  void initState() {
    super.initState();
    favoriteStream = getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
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
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
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
                              'My Favorites',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            favorites.isNotEmpty
                                ? Column(
                                    children: List.generate(favorites.length,
                                        (index) {
                                      final favoritesItem = favorites[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: FavoriteItems(
                                          id: favoritesItem['id'],
                                          imageUrl: favoritesItem['imageUrl'],
                                          furName: favoritesItem['furName'],
                                          ratings: favoritesItem['ratings'],
                                          price: favoritesItem['price'],
                                          currentPage: widget.currentPage,
                                        ),
                                      );
                                    }),
                                  )
                                : SizedBox(
                                    height: 700,
                                    child: Center(
                                      child: Text(
                                        'No favorites added',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  favorites.isNotEmpty
                      ? const SizedBox(
                          width: double.infinity,
                          child: ItemsLikeProduct(),
                        )
                      : Container(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
