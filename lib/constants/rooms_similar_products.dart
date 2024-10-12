import 'package:ciphen/database/roomsdb.dart';
import 'package:ciphen/screens/rooms_description_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RoomsSimilarProducts extends StatefulWidget {
  final int id;
  final int roomID;
  const RoomsSimilarProducts({
    super.key,
    required this.id,
    required this.roomID,
  });

  @override
  State<RoomsSimilarProducts> createState() => _RoomsSimilarProductsState();
}

class _RoomsSimilarProductsState extends State<RoomsSimilarProducts> {
  late Future<List<Map<String, dynamic>>> roomsFuture;
  final formatter = NumberFormat('#,##0');

  @override
  void initState() {
    super.initState();
    roomsFuture = getRoomsData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: roomsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final rooms = snapshot.data!;
        return SizedBox(
          height: 280,
          child: ListView.builder(
            itemCount: rooms
                .where((room) => room['roomID'] == widget.roomID)
                .where((room) => room['id'] != widget.id)
                .toList()
                .length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final roomsItem = rooms
                  .where((room) => room['roomID'] == widget.roomID)
                  .where((room) => room['id'] != widget.id)
                  .toList()[index];
              return Padding(
                padding: const EdgeInsets.all(8),
                child: GestureDetector(
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
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Image.network(
                                roomsItem['imageUrl'],
                                width: 150,
                              ),
                              Positioned(
                                top: 1,
                                left: 90,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                  ),
                                  child:
                                      const Icon(Icons.favorite_border_rounded),
                                ),
                              )
                            ],
                          ),
                          const Spacer(),
                          Text(
                            roomsItem['furName'],
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '\$${formatter.format(roomsItem['price'])}',
                            style: Theme.of(context).textTheme.titleLarge,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
