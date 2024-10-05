import 'package:firebase_database/firebase_database.dart';

final DatabaseReference dbReHome = FirebaseDatabase.instance.ref();

Future<List<Map<String, dynamic>>> getCategories() async {
  final DataSnapshot snapshot = await dbReHome.child('Categories').get();
  List<Map<String, dynamic>> exisitngCategories = [];
  if (snapshot.exists) {
    List<dynamic> values = snapshot.value as List<dynamic>;
    for (var value in values) {
      exisitngCategories.add({
        'id': value['id'],
        'catName': value['catName'],
        'imageUrl': value['imageUrl'],
      });
    }
  }
  return exisitngCategories;
}
