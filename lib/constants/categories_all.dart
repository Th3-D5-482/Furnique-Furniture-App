import 'package:flutter/material.dart';

class CategoriesAll extends StatelessWidget {
  final String catName;
  final String imageUrl;
  const CategoriesAll({
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
            top: 90,
            left: 20,
            child: Text(
              catName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ],
      ),
    );
  }
}
