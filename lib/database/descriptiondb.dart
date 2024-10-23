import 'package:firebase_database/firebase_database.dart';

final DatabaseReference dbDescription =
    FirebaseDatabase.instance.ref('Persons');

Future<List<Map<String, dynamic>>> getPersons() async {
  final DataSnapshot snapshot = await dbDescription.get();
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
