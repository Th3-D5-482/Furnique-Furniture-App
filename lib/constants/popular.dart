import 'package:flutter/material.dart';

class Popular extends StatefulWidget {
  const Popular({super.key});

  @override
  State<Popular> createState() => _PopularState();
}

class _PopularState extends State<Popular> {
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
          const Spacer(),
          Text(
            'Hello World',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '\$10',
            style: Theme.of(context).textTheme.titleLarge,
          )
        ],
      ),
    );
  }
}
