import 'package:flutter/material.dart';

class BannersCat extends StatefulWidget {
  final int banID;
  final String furName;
  final int price;
  final String imageUrl;
  const BannersCat({
    super.key,
    required this.banID,
    required this.furName,
    required this.price,
    required this.imageUrl,
  });

  @override
  State<BannersCat> createState() => _BannersCatState();
}

class _BannersCatState extends State<BannersCat> {
  late int discountedPrice = 0;
  @override
  void initState() {
    super.initState();
    if (widget.banID == 0) {
      discountedPrice = (widget.price - (widget.price * 70 / 100)).toInt();
    } else if (widget.banID == 1) {
      discountedPrice = (widget.price - (widget.price * 65 / 100)).toInt();
    } else if (widget.banID == 2) {
      discountedPrice = (widget.price - (widget.price * 75 / 100)).toInt();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                child: const Icon(Icons.favorite_border_rounded),
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
                    '\$${widget.price}',
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
                    '\$$discountedPrice',
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
