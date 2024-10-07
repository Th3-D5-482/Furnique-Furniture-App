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

Future<List<Map<String, dynamic>>> getBanners() async {
  final DataSnapshot snapshot = await dbReHome.child('Banners').get();
  List<Map<String, dynamic>> exisitingBanner = [];
  if (snapshot.exists) {
    List<dynamic> values = snapshot.value as List<dynamic>;
    for (var value in values) {
      exisitingBanner.add({
        'id': value['id'],
        'text1': value['text1'],
        'text2': value['text2'],
        'text3': value['text3'],
        'imageUrl': value['imageUrl'],
      });
    }
  }
  return exisitingBanner;
}

Future<List<Map<String, dynamic>>> getRooms() async {
  final DataSnapshot snapshot = await dbReHome.child('Rooms').get();
  List<Map<String, dynamic>> exisitingRooms = [];
  if (snapshot.exists) {
    List<dynamic> values = snapshot.value as List<dynamic>;
    for (var value in values) {
      exisitingRooms.add({
        'id': value['id'],
        'roomName': value['roomName'],
        'imageUrl': value['imageUrl'],
      });
    }
  }
  return exisitingRooms;
}
