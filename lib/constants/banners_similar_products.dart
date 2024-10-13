import 'package:ciphen/database/bannersdb.dart';
import 'package:ciphen/screens/banners_description_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BannersSimilarProducts extends StatefulWidget {
  final int id;
  final int banID;
  const BannersSimilarProducts({
    super.key,
    required this.id,
    required this.banID,
  });

  @override
  State<BannersSimilarProducts> createState() => _BannersSimilarProductsState();
}

class _BannersSimilarProductsState extends State<BannersSimilarProducts> {
  late Future<List<Map<String, dynamic>>> bannersFuture;
  final formatter = NumberFormat('#,##0');
  int discountedPrice = 0;

  @override
  void initState() {
    super.initState();
    bannersFuture = getBannersData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: bannersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final banners = snapshot.data!;
        return SizedBox(
          height: 280,
          child: ListView.builder(
            itemCount: banners
                .where((banner) => banner['banID'] == widget.banID)
                .where((banner) => banner['id'] != widget.id)
                .toList()
                .length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final bannersItem = banners
                  .where((banner) => banner['banID'] == widget.banID)
                  .where((banner) => banner['id'] != widget.id)
                  .toList()[index];
              int discount = widget.banID == 0
                  ? 70
                  : widget.banID == 1
                      ? 65
                      : 75;
              int discountedPrice = (bannersItem['price'] -
                      (bannersItem['price'] * discount / 100))
                  .toInt();
              return Padding(
                padding: const EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return BannersDescriptionPage(
                          id: bannersItem['id'],
                          banID: bannersItem['banID'],
                          ratings: bannersItem['ratings'],
                          imageUrl: bannersItem['imageUrl'],
                          furName: bannersItem['furName'],
                          price: bannersItem['price'],
                          description: bannersItem['description'],
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
                                bannersItem['imageUrl'],
                                width: 150,
                              ),
                              Positioned(
                                top: 1,
                                left: 90,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                  ),
                                  child:
                                      const Icon(Icons.favorite_border_rounded),
                                ),
                              )
                            ],
                          ),
                          const Spacer(),
                          Text(
                            bannersItem['furName'],
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                '\$${formatter.format(bannersItem['price'])}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      decoration: TextDecoration.lineThrough,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '\$${formatter.format(discountedPrice)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                              )
                            ],
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
  }
}
