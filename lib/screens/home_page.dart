import 'package:ciphen/constants/banners.dart';
import 'package:ciphen/constants/categories.dart';
import 'package:ciphen/database/homedb.dart';
import 'package:ciphen/screens/cart_page.dart';
import 'package:ciphen/screens/favorites_page.dart';
import 'package:ciphen/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentPage,
        children: const [
          SubHomePage(),
          FavoritesPage(),
          CartPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        iconSize: 32,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        onTap: (value) {
          setState(() {
            currentPage = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_filled),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_rounded),
            activeIcon: Icon(Icons.favorite_rounded),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag_rounded),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            activeIcon: Icon(Icons.person),
            label: '',
          )
        ],
      ),
    );
  }
}

class SubHomePage extends StatefulWidget {
  const SubHomePage({super.key});

  @override
  State<SubHomePage> createState() => _SubHomePageState();
}

class _SubHomePageState extends State<SubHomePage> {
  late Future<List<Map<String, dynamic>>> categoriesFuture;
  late final PageController _pageController = PageController();
  late Future<List<Map<String, dynamic>>> bannerFuture;

  @override
  void initState() {
    super.initState();
    categoriesFuture = getCategories();
    bannerFuture = getBanners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: Future.wait([
            categoriesFuture,
            bannerFuture,
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
            final categories = snapshot.data![0];
            final banners = snapshot.data![1];
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Explore What\nYour Home Needs',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Chair, desk, lamp, etc',
                      hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        size: 32,
                      ),
                      prefixIconColor: Theme.of(context).colorScheme.tertiary,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Color.fromRGBO(222, 222, 222, 1),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Color.fromRGBO(222, 222, 222, 1),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        'Categories',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        width: 170,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Row(
                          children: [
                            Text('See all'),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 16,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      itemCount: categories.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final categoryItem = categories[index];
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Categories(
                            catName: categoryItem['catName'],
                            imageUrl: categoryItem['imageUrl'],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 210,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: banners.length,
                      itemBuilder: (context, index) {
                        final pageViewItem = banners[index];
                        return Card(
                          child: Column(
                            children: [
                              Banners(
                                text1: pageViewItem['text1'],
                                text2: pageViewItem['text2'],
                                text3: pageViewItem['text3'],
                                imageUrl: pageViewItem['imageUrl'],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      effect: const ScrollingDotsEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                      ),
                      count: 3,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
