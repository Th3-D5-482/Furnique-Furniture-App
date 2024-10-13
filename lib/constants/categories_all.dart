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
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 90),
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
