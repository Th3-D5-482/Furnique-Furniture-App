import 'package:firebase_database/firebase_database.dart';

final DatabaseReference dbDescription = FirebaseDatabase.instance.ref();

Future<List<Map<String, dynamic>>> getPersons() async {
  final DataSnapshot snapshot = await dbDescription.child('Persons').get();
  List<Map<String, dynamic>> exisitingPerson = [];
  if (snapshot.exists) {
    List<dynamic> values = snapshot.value as List<dynamic>;
    for (var value in values) {
      exisitingPerson.add({
        'id': value['id'],
        'imageUrl': value['imageUrl'],
        'personName': value['personName']
      });
    }
  }
  return exisitingPerson;
}

Future<List<Map<String, dynamic>>> getReviews() async {
  final DataSnapshot snapshot = await dbDescription.child('Reviews').get();
  List<Map<String, dynamic>> existingReviews = [];
  if (snapshot.exists) {
    List<dynamic> values = snapshot.value as List<dynamic>;
    for (var value in values) {
      existingReviews.add({
        'id': value['id'],
        'ratings': value['ratings'],
        'description': value['description'],
      });
    }
  }
  return existingReviews;
}
