import 'package:ciphen/database/cartdb.dart';
import 'package:ciphen/database/favoritesdb.dart';
import 'package:flutter/material.dart';

void deleteConfirmBox(
  int id,
  BuildContext context,
  int currentPage,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Delete Confirmation'),
        content: const Text('Are you sure you want to delete this item?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (currentPage == 1) {
                deleteFavorites(
                  id,
                  context,
                );
              } else if (currentPage == 2) {
                deleteCart(
                  id,
                  context,
                );
              }
              Navigator.of(context).pop();
            },
            child: const Text('Confirm'),
          )
        ],
      );
    },
  );
}
