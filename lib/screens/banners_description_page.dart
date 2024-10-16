import 'package:ciphen/constants/similar_products.dart';
import 'package:ciphen/database/cartdb.dart';
import 'package:ciphen/database/descriptiondb.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class BannersDescriptionPage extends StatefulWidget {
  final int id;
  final int catID;
  final double ratings;
  final String imageUrl;
  final String furName;
  final int price;
  final String description;
  bool isFavorite;
  BannersDescriptionPage({
    super.key,
    required this.id,
    required this.catID,
    required this.ratings,
    required this.imageUrl,
    required this.furName,
    required this.price,
    required this.description,
    required this.isFavorite,
  });

  @override
  State<BannersDescriptionPage> createState() => _BannersDescriptionPageState();
}

class _BannersDescriptionPageState extends State<BannersDescriptionPage> {
  late Future<List<Map<String, dynamic>>> personFuture;
  final List<String> tabsNames = [
    'Description',
    'Materials',
    'Reviews',
  ];
  int currentTabSelected = 0;
  int numberInCart = 1;
  int discountedPrice = 0;
  final formatter = NumberFormat('#,##0');

  @override
  void initState() {
    super.initState();
    personFuture = getPersons();
    if (widget.catID == 3) {
      discountedPrice = (widget.price - (widget.price * 70 / 100)).toInt();
    } else if (widget.catID == 4) {
      discountedPrice = (widget.price - (widget.price * 65 / 100)).toInt();
    } else if (widget.catID == 5) {
      discountedPrice = (widget.price - (widget.price * 75 / 100)).toInt();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: personFuture,
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
          final personFace = snapshot.data!;
          return Column(
            children: [
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Image.network(
                            widget.imageUrl,
                          ),
                          Positioned(
                            top: 40,
                            left: 5,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios,
                                size: 28,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          elevation: 20,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.furName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(fontWeight: FontWeight.normal),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '\$${formatter.format(widget.price)}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            decoration:
                                                TextDecoration.lineThrough,
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
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        if (numberInCart != 1) {
                                          setState(() {
                                            numberInCart--;
                                          });
                                        }
                                      },
                                      child: Icon(
                                        Icons.indeterminate_check_box_outlined,
                                        size: 32,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '$numberInCart',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          numberInCart++;
                                        });
                                      },
                                      child: Icon(
                                        Icons.add_box_outlined,
                                        size: 32,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Row(
                                            children: [
                                              Row(
                                                children:
                                                    List.generate(5, (index) {
                                                  return Icon(
                                                    index < 5
                                                        ? Icons.star
                                                        : Icons.star,
                                                    color: index <
                                                            widget.ratings
                                                                .floor()
                                                        ? Colors.yellow
                                                        : Colors.grey,
                                                    size: 28,
                                                  );
                                                }),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                '${widget.ratings}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              )
                                            ],
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              currentTabSelected = 2;
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                '4 Reviews',
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
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                size: 16,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 130,
                                          child: Stack(
                                            children: List.generate(
                                                personFace.length, (index) {
                                              final avatarFaces =
                                                  personFace[index];
                                              if (index == 0) {
                                                return CircleAvatar(
                                                  foregroundImage: NetworkImage(
                                                    avatarFaces['imageUrl'],
                                                  ),
                                                  radius: 20,
                                                );
                                              } else {
                                                return Positioned(
                                                  left: index * 30,
                                                  child: CircleAvatar(
                                                    foregroundImage:
                                                        NetworkImage(
                                                            avatarFaces[
                                                                'imageUrl']),
                                                    radius: 20,
                                                  ),
                                                );
                                              }
                                            }),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                  height: 50,
                                  child: ListView.builder(
                                    itemCount: tabsNames.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final tabItem = tabsNames[index];
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            currentTabSelected = index;
                                          });
                                        },
                                        child: Card(
                                          color: currentTabSelected == index
                                              ? const Color.fromRGBO(
                                                  255, 238, 221, 1)
                                              : null,
                                          elevation: 0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                              tabItem,
                                              style: currentTabSelected == index
                                                  ? Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                      )
                                                  : Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary,
                                                      ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  child: Text(
                                    widget.description,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Similar products',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                SimilarProducts(
                                  id: widget.id,
                                  catID: widget.catID,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        side: BorderSide(
                          width: 2,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        padding: const EdgeInsets.all(10),
                      ),
                      child: widget.isFavorite
                          ? const Icon(
                              Icons.favorite_rounded,
                              size: 32,
                            )
                          : const Icon(
                              Icons.favorite_border_rounded,
                              size: 32,
                            ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          addToCart(
                            widget.id,
                            widget.catID,
                            widget.furName,
                            widget.imageUrl,
                            discountedPrice,
                            widget.ratings,
                            widget.description,
                            numberInCart,
                            context,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.all(16),
                        ),
                        child: Text(
                          'Add to bag',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
