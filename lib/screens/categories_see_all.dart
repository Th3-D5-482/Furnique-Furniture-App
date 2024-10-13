import 'package:ciphen/constants/categories_all.dart';
import 'package:ciphen/database/homedb.dart';
import 'package:ciphen/screens/category_page.dart';
import 'package:flutter/material.dart';

class CategoriesSeeAll extends StatefulWidget {
  const CategoriesSeeAll({super.key});

  @override
  State<CategoriesSeeAll> createState() => _CategoriesSeeAllState();
}

class _CategoriesSeeAllState extends State<CategoriesSeeAll> {
  late Future<List<Map<String, dynamic>>> categoriesFuture;

  @override
  void initState() {
    super.initState();
    categoriesFuture = getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: categoriesFuture,
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
          final categories = snapshot.data!;
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
                    'All Categories',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SizedBox(
                        height: 650,
                        child: ListView.builder(
                          itemCount: categories.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            final categoriesItem = categories[index];
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return CategoryPage(
                                        id: categoriesItem['id'],
                                        catName: categoriesItem['catName'],
                                      );
                                    },
                                  ));
                                },
                                child: Card(
                                  child: CategoriesAll(
                                    catName: categoriesItem['catName'],
                                    imageUrl: categoriesItem['imageUrl'],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
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
