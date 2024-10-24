import 'package:ciphen/database/descriptiondb.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Reviews extends StatefulWidget {
  final int catID;
  const Reviews({
    super.key,
    required this.catID,
  });

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  final PageController _pageController = PageController();
  late Future<List<Map<String, dynamic>>> personFuture;
  late Future<List<Map<String, dynamic>>> reviewsFuture;

  @override
  void initState() {
    super.initState();
    personFuture = getPersons();
    reviewsFuture = getReviews();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        personFuture,
        reviewsFuture,
      ]),
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
        final personFace = snapshot.data![0];
        final reviews = snapshot.data![1];
        return Column(
          children: [
            SizedBox(
              height: 230,
              child: PageView.builder(
                controller: _pageController,
                itemCount: reviews.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final avatarFaces = personFace[index];
                  final reviewItems = reviews[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            foregroundImage: NetworkImage(
                              avatarFaces['imageUrl'],
                            ),
                            radius: 25,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  avatarFaces['personName'],
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: List.generate(5, (index) {
                                        return Icon(
                                          index > 5 ? Icons.star : Icons.star,
                                          color:
                                              reviewItems['ratings'].floor() >
                                                      index
                                                  ? Colors.yellow
                                                  : Colors.grey,
                                        );
                                      }),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '${reviewItems['ratings']}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    reviewItems['description'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.normal,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SmoothPageIndicator(
              controller: _pageController,
              count: 4,
              effect: const ScrollingDotsEffect(
                dotHeight: 8,
                dotWidth: 8,
                activeDotColor: Color.fromRGBO(78, 84, 113, 1),
              ),
            )
          ],
        );
      },
    );
  }
}
