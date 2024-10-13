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
    return Expanded(
      child: Stack(
        children: [
          Image.network(
            imageUrl,
          ),
          Positioned(
            top: 25,
            left: 8,
            child: Text(
              catName,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
