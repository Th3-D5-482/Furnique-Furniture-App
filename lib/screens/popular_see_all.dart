import 'package:ciphen/constants/popular.dart';
import 'package:ciphen/database/homedb.dart';
import 'package:ciphen/screens/description_page.dart';
import 'package:flutter/material.dart';

class PopularSeeAll extends StatefulWidget {
  const PopularSeeAll({super.key});

  @override
  State<PopularSeeAll> createState() => _PopularSeeAllState();
}

class _PopularSeeAllState extends State<PopularSeeAll> {
  late Future<List<Map<String, dynamic>>> furnitureFuture;

  @override
  void initState() {
    super.initState();
    furnitureFuture = getFurnitures();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: furnitureFuture,
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
                    'Popular Items',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: GridView.builder(
                      itemCount: furnitures
                          .where((furniture) => furniture['isPopular'] == true)
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
                        final furnituresItems = furnitures
                            .where(
                                (furniture) => furniture['isPopular'] == true)
                            .toList()[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return DescriptionPage(
                                  id: furnituresItems['id'],
                                  catID: furnituresItems['catID'],
                                  ratings: furnituresItems['ratings'],
                                  imageUrl: furnituresItems['imageUrl'],
                                  furName: furnituresItems['furName'],
                                  price: furnituresItems['price'],
                                  description: furnituresItems['description'],
                                );
                              },
                            ));
                          },
                          child: Card(
                            child: Popular(
                              id: furnituresItems['id'],
                              catID: furnituresItems['catID'],
                              imageUrl: furnituresItems['imageUrl'],
                              furName: furnituresItems['furName'],
                              price: furnituresItems['price'],
                              ratings: furnituresItems['ratings'],
                              description: furnituresItems['description'],
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
      ),
    );
  }
}
