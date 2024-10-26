import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

final DatabaseReference dbRefCart = FirebaseDatabase.instance.ref('Cart');
User? users = FirebaseAuth.instance.currentUser;
String? getLoggedEmailID = users?.email;
String sanitizedEmailID = (getLoggedEmailID ?? '').replaceAll('.', ',');

void addToCart(
  int id,
  int catID,
  String furName,
  String imageUrl,
  int price,
  double ratings,
  String description,
  int numberInCart,
  BuildContext context,
) async {
  final DatabaseEvent event = await dbRefCart
      .child(sanitizedEmailID)
      .orderByChild('id')
      .equalTo(id)
      .once();
  if (event.snapshot.value != null) {
    // ignore: use_build_context_synchronously
    updateNumberInCart(
      id,
      numberInCart,
      // ignore: use_build_context_synchronously
      context,
    );
  } else {
    await dbRefCart.child(sanitizedEmailID).child(id.toString()).set({
      'id': id,
      'catID': catID,
      'furName': furName,
      'imageUrl': imageUrl,
      'price': price,
      'ratings': ratings,
      'description': description,
      'numberInCart': numberInCart,
      'totalPrice': price,
    });
    // ignore: use_build_context_synchronously
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Added to Shopping Bag'),
        ),
      );
    }
  }
}

Stream<List<Map<String, dynamic>>> getCart() async* {
  yield* dbRefCart.child(sanitizedEmailID).onValue.map((event) {
    final DataSnapshot snapshot = event.snapshot;
    List<Map<String, dynamic>> existingCart = [];
    if (snapshot.exists && snapshot.value != null) {
      if (snapshot.value is List) {
        List<dynamic> values = snapshot.value as List<dynamic>;
        for (var value in values) {
          if (value != null) {
            existingCart.add({
              'id': value['id'] ?? '',
              'catID': value['catID'] ?? '',
              'furName': value['furName'] ?? '',
              'imageUrl': value['imageUrl'] ?? '',
              'totalPrice': value['totalPrice'] ?? 0,
              'ratings': value['ratings'] ?? 0.0,
              'description': value['description'] ?? '',
              'numberInCart': value['numberInCart'] ?? 0,
            });
          }
        }
      } else if (snapshot.value is Map) {
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          if (value != null) {
            existingCart.add({
              'id': value['id'] ?? '',
              'catID': value['catID'] ?? '',
              'furName': value['furName'] ?? '',
              'imageUrl': value['imageUrl'] ?? '',
              'totalPrice': value['totalPrice'] ?? 0,
              'ratings': value['ratings'] ?? 0.0,
              'description': value['description'] ?? '',
              'numberInCart': value['numberInCart'] ?? 0,
            });
          }
        });
      }
    }
    return existingCart;
  });
}

void deleteCart(
  int id,
  BuildContext context,
) async {
  DatabaseEvent event = await dbRefCart
      .child(sanitizedEmailID)
      .orderByChild('id')
      .equalTo(id)
      .once();
  if (event.snapshot.value != null) {
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Removed from Shopping Bag'),
      ),
    );
    await dbRefCart.child(sanitizedEmailID).child(id.toString()).remove();
  }
}

void increaseCart(
  int id,
) async {
  int numberInCart = 0;
  int totalPrice = 0;
  final DatabaseEvent event = await dbRefCart
      .child(sanitizedEmailID)
      .orderByChild('id')
      .equalTo(id)
      .once();
  final DataSnapshot snapshot = event.snapshot;
  if (snapshot.exists) {
    if (snapshot.value is List) {
      List<dynamic> values = snapshot.value as List<dynamic>;
      for (var value in values) {
        numberInCart = value['numberInCart'] + 1;
        totalPrice = value['price'] * numberInCart;
      }
    } else if (snapshot.value is Map) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      values.forEach((key, value) {
        numberInCart = value['numberInCart'] + 1;
        totalPrice = value['price'] * numberInCart;
      });
    }
    await dbRefCart.child(sanitizedEmailID).child(id.toString()).update({
      'numberInCart': numberInCart,
      'totalPrice': totalPrice,
    });
  }
}

void decrementCart(
  int id,
) async {
  int numberInCart = 0;
  int totalPrice = 0;
  final DatabaseEvent event = await dbRefCart
      .child(sanitizedEmailID)
      .orderByChild('id')
      .equalTo(id)
      .once();
  final DataSnapshot snapshot = event.snapshot;
  if (snapshot.exists) {
    if (snapshot.value is List) {
      List<dynamic> values = snapshot.value as List<dynamic>;
      for (var value in values) {
        numberInCart = value['numberInCart'] - 1;
        totalPrice = value['price'] * numberInCart;
      }
    } else if (snapshot.value is Map) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      values.forEach((key, value) {
        numberInCart = value['numberInCart'] - 1;
        totalPrice = value['price'] * numberInCart;
      });
    }
    await dbRefCart.child(sanitizedEmailID).child(id.toString()).update({
      'numberInCart': numberInCart,
      'totalPrice': totalPrice,
    });
  }
}

void updateNumberInCart(
  int id,
  int numberInCart,
  BuildContext context,
) async {
  late int existingNumberInCart;
  final DatabaseEvent event = await dbRefCart
      .child(sanitizedEmailID)
      .orderByChild('id')
      .equalTo(id)
      .once();
  final DataSnapshot snapshot = event.snapshot;
  if (snapshot.exists) {
    List<dynamic> values = snapshot.value as List<dynamic>;
    for (var value in values) {
      existingNumberInCart = value['numberInCart'];
    }
    if (existingNumberInCart != numberInCart) {
      await dbRefCart.child(sanitizedEmailID).child(id.toString()).update({
        'numberInCart': numberInCart + existingNumberInCart,
      });
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Update Shopping Bag'),
        ),
      );
    }
  }
}
