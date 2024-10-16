import 'package:ciphen/constants/popular.dart';
import 'package:ciphen/database/homedb.dart';
import 'package:ciphen/screens/description_page.dart';
import 'package:flutter/material.dart';

class RoomPage extends StatefulWidget {
  final int id;
  final String catName;
  const RoomPage({
    super.key,
    required this.id,
    required this.catName,
  });

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  late Stream<List<Map<String, dynamic>>> funituresStream;

  @override
  void initState() {
    super.initState();
    funituresStream = getFurnitures();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: funituresStream,
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
                    'Room: ${widget.catName} Room Items',
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
                              furniture['catID'] == widget.id + 3)
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
                        final furnituresItem = furnitures
                            .where((furniture) =>
                                furniture['catID'] == widget.id + 3)
                            .toList()[index];
                        return GestureDetector(
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
                                  isFavorite: furnituresItem['isFavorite'],
                                );
                              },
                            ));
                          },
                          child: Card(
                            child: Popular(
                              imageUrl: furnituresItem['imageUrl'],
                              furName: furnituresItem['furName'],
                              price: furnituresItem['price'],
                              isFavorite: furnituresItem['isFavorite'],
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
