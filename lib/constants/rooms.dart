import 'package:flutter/material.dart';

class Rooms extends StatelessWidget {
  final String imageUrl;
  final String catName;
  const Rooms({
    super.key,
    required this.imageUrl,
    required this.catName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Stack(
            children: [
              Image.network(
                imageUrl,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      catName,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      'Room',
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
