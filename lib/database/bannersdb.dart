import 'package:firebase_database/firebase_database.dart';

final DatabaseReference dbRefBanners =
    FirebaseDatabase.instance.ref('BannersFurnitures');

Future<List<Map<String, dynamic>>> getBannersData() async {
  final DataSnapshot snapshot = await dbRefBanners.get();
  List<Map<String, dynamic>> exisitingBanners = [];
  if (snapshot.exists) {
    List<dynamic> values = snapshot.value as List<dynamic>;
    for (var value in values) {
      exisitingBanners.add({
        'id': value['id'],
        'banID': value['banID'],
        'furName': value['furName'],
        'price': value['price'],
        'imageUrl': value['imageUrl'],
      });
    }
  }
  return exisitingBanners;
}
