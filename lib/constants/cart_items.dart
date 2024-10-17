import 'package:ciphen/constants/delete_confirm_box.dart';
import 'package:ciphen/database/cartdb.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CartItems extends StatelessWidget {
  final int id;
  final int numberInCart;
  final int totalPrice;
  final String imageUrl;
  final String furName;
  final int currentPage;
  const CartItems({
    super.key,
    required this.id,
    required this.numberInCart,
    required this.totalPrice,
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          deleteConfirmBox(
                            id,
                            context,
                            currentPage,
                          );
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
                  Text(
                    'Qty: $numberInCart',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (numberInCart > 1) {
                            decrementCart(
                              id,
                            );
                          }
                        },
                        child: Icon(
                          Icons.indeterminate_check_box_outlined,
                          size: 32,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '$numberInCart',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          increaseCart(
                            id,
                          );
                        },
                        child: Icon(
                          Icons.add_box_outlined,
                          size: 32,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '\$${formatter.format(totalPrice)}',
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
