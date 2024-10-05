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
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Text(
              catName,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              width: 20,
            ),
            Image.network(
              imageUrl,
            )
          ],
        ),
      ),
    );
  }
}
