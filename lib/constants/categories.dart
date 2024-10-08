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
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  catName,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
