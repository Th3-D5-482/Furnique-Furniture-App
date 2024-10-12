import 'package:firebase_database/firebase_database.dart';

final DatabaseReference dbRefRooms =
    FirebaseDatabase.instance.ref('RoomsFurnitures');

Future<List<Map<String, dynamic>>> getRoomsData() async {
  final DataSnapshot snapshot = await dbRefRooms.get();
  List<Map<String, dynamic>> existingRooms = [];
  if (snapshot.exists) {
    List<dynamic> values = snapshot.value as List<dynamic>;
    for (var value in values) {
      existingRooms.add({
        'id': value['id'],
        'roomID': value['roomID'],
        'price': value['price'],
        'furName': value['furName'],
        'imageUrl': value['imageUrl'],
        'description': value['description'],
        'ratings': value['ratings'],
      });
    }
  }
  return existingRooms;
}
