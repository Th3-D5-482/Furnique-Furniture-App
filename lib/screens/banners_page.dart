import 'package:ciphen/constants/banners_cat.dart';
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
  late Stream<List<Map<String, dynamic>>> furnituresStream;

  @override
  void initState() {
    super.initState();
    furnituresStream = getFurnitures();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: furnituresStream,
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
                          .where((banner) => banner['catID'] == widget.id + 3)
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
                                  description: furnituresItems['description'],
                                  isFavorite: furnituresItems['isFavorite'],
                                );
                              },
                            ));
                          },
                          child: Card(
                            child: BannersCat(
                              catID: furnituresItems['catID'],
                              furName: furnituresItems['furName'],
                              price: furnituresItems['price'],
                              imageUrl: furnituresItems['imageUrl'],
                              isFavorite: furnituresItems['isFavorite'],
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
