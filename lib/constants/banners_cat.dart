import 'package:flutter/material.dart';

class BannersCat extends StatefulWidget {
  const BannersCat({super.key});

  @override
  State<BannersCat> createState() => _BannersCatState();
}

class _BannersCatState extends State<BannersCat> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/images/banners/chair.png',
                width: double.infinity,
              ),
              Positioned(
                top: -10,
                left: 90,
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
          const SizedBox(
            height: 10,
          ),
          Text(
            'Hello World',
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
                '\$10',
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
                '\$3',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: const Color.fromRGBO(226, 71, 71, 1),
                    ),
              )
            ],
          )
        ],
      ),
    );
  }
}
