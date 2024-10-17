import 'package:ciphen/constants/delete_confirm_box.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FavoriteItems extends StatelessWidget {
  final int id;
  final double ratings;
  final int price;
  final String imageUrl;
  final String furName;
  final int currentPage;
  const FavoriteItems({
    super.key,
    required this.id,
    required this.ratings,
    required this.price,
    required this.imageUrl,
    required this.furName,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,##0');
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: 100,
              height: 110,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        furName,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          deleteConfirmBox(id, context, currentPage);
                        },
                        child: Icon(
                          Icons.cancel_outlined,
                          size: 32,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 28,
                        color: Colors.yellow,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '$ratings',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                      const Spacer(),
                      Text(
                        '\$${formatter.format(price)}',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
