import 'package:ciphen/database/cartdb.dart';
import 'package:flutter/material.dart';

void deleteConfirmBox(
  int id,
  BuildContext context,
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
              deleteCart(id, context);
              Navigator.of(context).pop();
            },
            child: const Text('Confirm'),
          )
        ],
      );
    },
  );
}
