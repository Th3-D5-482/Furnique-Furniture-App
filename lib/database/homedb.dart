import 'package:firebase_database/firebase_database.dart';

final DatabaseReference dbRefHome = FirebaseDatabase.instance.ref();

Future<List<Map<String, dynamic>>> getCategories() async {
  final DataSnapshot snapshot = await dbRefHome.child('Categories').get();
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
  final DataSnapshot snapshot = await dbRefHome.child('Banners').get();
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
  final DataSnapshot snapshot = await dbRefHome.child('Rooms').get();
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

Future<List<Map<String, dynamic>>> getFurnitures() async {
  final DataSnapshot snapshot = await dbRefHome.child('Furnitures').get();
  List<Map<String, dynamic>> exisitingFurniture = [];
  if (snapshot.exists) {
    List<dynamic> values = snapshot.value as List<dynamic>;
    for (var value in values) {
      exisitingFurniture.add({
        'id': value['id'],
        'catID': value['catID'],
        'furName': value['furName'],
        'imageUrl': value['imageUrl'],
        'price': value['price'],
        'isPopular': value['isPopular'],
        'ratings': value['ratings'],
        'description': value['description'],
      });
    }
  }
  return exisitingFurniture;
}
