import 'package:ciphen/database/homedb.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class BannersCat extends StatefulWidget {
  final int id;
  final int catID;
  final String furName;
  final int price;
  final String imageUrl;
  bool isFavorite;
  BannersCat({
    super.key,
    required this.id,
    required this.catID,
    required this.furName,
    required this.price,
    required this.imageUrl,
    required this.isFavorite,
  });

  @override
  State<BannersCat> createState() => _BannersCatState();
}

class _BannersCatState extends State<BannersCat> {
  late int discountedPrice = 0;
  @override
  void initState() {
    super.initState();
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
    final formatter = NumberFormat('#,##0');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Image.network(
              widget.imageUrl,
              width: double.infinity,
            ),
            Positioned(
              top: 2,
              left: 110,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      updateFavorites(
                        widget.id,
                        widget.isFavorite,
                      );
                    });
                  },
                  child: widget.isFavorite
                      ? const Icon(Icons.favorite_rounded)
                      : const Icon(Icons.favorite_border_rounded),
                ),
              ),
            )
          ],
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.furName,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    '\$${formatter.format(widget.price)}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 22,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '\$${formatter.format(discountedPrice)}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
