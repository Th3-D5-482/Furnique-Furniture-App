import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  final String catName;
  final String imageUrl;
  const Categories({
    super.key,
    required this.catName,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          imageUrl,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, top: 25),
          child: Text(
            catName,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
