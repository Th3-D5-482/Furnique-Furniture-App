import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

final DatabaseReference dbRefFavorites =
    FirebaseDatabase.instance.ref('Favorites');

void addToFavorites(
  int id,
  int catID,
  String furName,
  String imageUrl,
  int price,
  double ratings,
  String description,
  BuildContext context,
) async {
  final DatabaseEvent event =
      await dbRefFavorites.orderByChild('id').equalTo(id).once();
  if (event.snapshot.value != null) {
    // ignore: use_build_context_synchronously
    deleteFavorites(id, context);
  } else {
    await dbRefFavorites.child(id.toString()).set({
      'id': id,
      'catID': catID,
      'furName': furName,
      'imageUrl': imageUrl,
      'price': price,
      'ratings': ratings,
      'description': description,
    });
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Added to Favorites'),
      ),
    );
  }
}

Stream<List<Map<String, dynamic>>> getFavorites() async* {
  yield* dbRefFavorites.onValue.map((event) {
    final DataSnapshot snapshot = event.snapshot;
    List<Map<String, dynamic>> existingFavorites = [];
    if (snapshot.exists && snapshot.value != null) {
      if (snapshot.value is List) {
        List<dynamic> values = snapshot.value as List<dynamic>;
        for (var value in values) {
          if (value != null) {
            existingFavorites.add({
              'id': value['id'],
              'catID': value['catID'],
              'furName': value['furName'],
              'imageUrl': value['imageUrl'],
              'price': value['price'],
              'ratings': value['ratings'],
              'description': value['description'],
            });
          }
        }
      } else if (snapshot.value is Map) {
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          if (value != null) {
            existingFavorites.add({
              'id': value['id'],
              'catID': value['catID'],
              'furName': value['furName'],
              'imageUrl': value['imageUrl'],
              'price': value['price'],
              'ratings': value['ratings'],
              'description': value['description'],
            });
          }
        });
      }
    }
    return existingFavorites;
  });
}

void deleteFavorites(
  int id,
  BuildContext context,
) async {
  final DatabaseEvent event =
      await dbRefFavorites.orderByChild('id').equalTo(id).once();
  if (event.snapshot.value != null) {
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Removed from Favorites'),
      ),
    );
    await dbRefFavorites.child(id.toString()).remove();
  }
}
