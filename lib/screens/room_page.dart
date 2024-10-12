import 'package:ciphen/constants/popular.dart';
import 'package:ciphen/database/roomsdb.dart';
import 'package:ciphen/screens/rooms_description_page.dart';
import 'package:flutter/material.dart';

class RoomPage extends StatefulWidget {
  final int id;
  final String roomName;
  const RoomPage({
    super.key,
    required this.id,
    required this.roomName,
  });

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  late Future<List<Map<String, dynamic>>> roomsFuture;

  @override
  void initState() {
    super.initState();
    roomsFuture = getRoomsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: roomsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          final rooms = snapshot.data!;
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 28,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Room: ${widget.roomName} Room Items',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: GridView.builder(
                        itemCount: rooms
                            .where((room) => room['roomID'] == widget.id)
                            .length,
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.57,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final roomsItem = rooms
                              .where((room) => room['roomID'] == widget.id)
                              .toList()[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return RoomsDescriptionPage(
                                    id: roomsItem['id'],
                                    roomID: roomsItem['roomID'],
                                    ratings: roomsItem['ratings'],
                                    imageUrl: roomsItem['imageUrl'],
                                    furName: roomsItem['furName'],
                                    price: roomsItem['price'],
                                    description: roomsItem['description'],
                                  );
                                },
                              ));
                            },
                            child: Card(
                              child: Popular(
                                imageUrl: roomsItem['imageUrl'],
                                furName: roomsItem['furName'],
                                price: roomsItem['price'],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
