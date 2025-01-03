import 'package:ciphen/constants/banners.dart';
import 'package:ciphen/constants/categories.dart';
import 'package:ciphen/constants/popular.dart';
import 'package:ciphen/constants/rooms.dart';
import 'package:ciphen/database/favoritesdb.dart';
import 'package:ciphen/database/homedb.dart';
import 'package:ciphen/screens/banners_page.dart';
import 'package:ciphen/screens/categories_see_all.dart';
import 'package:ciphen/screens/category_page.dart';
import 'package:ciphen/screens/description_page.dart';
import 'package:ciphen/screens/cart_page.dart';
import 'package:ciphen/screens/favorite_page.dart';
import 'package:ciphen/screens/popular_see_all.dart';
import 'package:ciphen/screens/profile_page.dart';
import 'package:ciphen/screens/room_page.dart';
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
    // ignore: deprecated_member_use
    return Scaffold(
      body: IndexedStack(
        index: currentPage,
        children: [
          const SubHomePage(),
          FavoritePage(
            currentPage: currentPage,
          ),
          CartPage(
            currentPage: currentPage,
          ),
          const ProfilePage(),
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
  late TextEditingController search = TextEditingController();
  late final PageController _pageController = PageController();
  late Future<List<Map<String, dynamic>>> categoriesFuture;
  late Future<List<Map<String, dynamic>>> bannerFuture;
  late Future<List<Map<String, dynamic>>> furnitureFuture;
  late Stream<List<Map<String, dynamic>>> favoriteStream;
  bool isSearchFound = false;

  @override
  void initState() {
    super.initState();
    categoriesFuture = getCategories();
    bannerFuture = getBanners();
    furnitureFuture = getFurnitures();
    favoriteStream = getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: FutureBuilder(
            future: Future.wait([
              categoriesFuture,
              bannerFuture,
              furnitureFuture,
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
              final furnitures = snapshot.data![2];
              return StreamBuilder(
                stream: favoriteStream,
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
                  final favorites = snapshot.data!;
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Explore What\nYour Home Needs',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: search,
                            decoration: InputDecoration(
                              hintText: 'Chairs, sofas, desks, etc',
                              hintStyle: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              prefixIcon: Icon(
                                Icons.search_rounded,
                                size: 32,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              prefixIconColor: Theme.of(context)
                                  .inputDecorationTheme
                                  .prefixIconColor,
                              enabledBorder: Theme.of(context)
                                  .inputDecorationTheme
                                  .enabledBorder,
                              focusedBorder: Theme.of(context)
                                  .inputDecorationTheme
                                  .enabledBorder,
                            ),
                            onSubmitted: (value) {
                              if (search.text.trim().isNotEmpty) {
                                if (search.text.trim().toLowerCase() == 'chair' ||
                                    search.text.trim().toLowerCase() ==
                                        'chairs') {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return const CategoryPage(
                                        id: 0,
                                        catName: 'Chairs',
                                      );
                                    },
                                  ));
                                  search.clear();
                                } else if (search.text.trim().toLowerCase() ==
                                        'sofa' ||
                                    search.text.trim().toLowerCase() ==
                                        'sofas') {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return const CategoryPage(
                                        id: 1,
                                        catName: 'Sofas',
                                      );
                                    },
                                  ));
                                  search.clear();
                                } else if (search.text.trim().toLowerCase() ==
                                        'desk' ||
                                    search.text.trim().toLowerCase() ==
                                        'desks') {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return const CategoryPage(
                                        id: 2,
                                        catName: 'Desks',
                                      );
                                    },
                                  ));
                                  search.clear();
                                } else if (search.text.trim().toLowerCase() ==
                                        '70%' ||
                                    search.text.trim().toLowerCase() ==
                                        '70% off') {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return const BannersPage(
                                        id: 0,
                                        text1: 'High-Quality-Sofa',
                                        text3: '70%',
                                      );
                                    },
                                  ));
                                  search.clear();
                                } else if (search.text.trim().toLowerCase() ==
                                        '65%' ||
                                    search.text.trim().toLowerCase() ==
                                        '65% off') {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return const BannersPage(
                                        id: 1,
                                        text1: 'Ergonomic Chair',
                                        text3: '65%',
                                      );
                                    },
                                  ));
                                  search.clear();
                                } else if (search.text.trim().toLowerCase() ==
                                        '75%' ||
                                    search.text.trim().toLowerCase() ==
                                        '75% off') {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return const BannersPage(
                                          id: 2,
                                          text1: 'Premium Desk',
                                          text3: '75%');
                                    },
                                  ));
                                  search.clear();
                                } else if (search.text.trim().toLowerCase() ==
                                        'dining' ||
                                    search.text.trim().toLowerCase() ==
                                        'dining room') {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return const RoomPage(
                                        id: 3,
                                        catName: 'Dining',
                                      );
                                    },
                                  ));
                                  search.clear();
                                } else if (search.text.trim().toLowerCase() ==
                                        'bed' ||
                                    search.text.toLowerCase() == 'bed room') {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return const RoomPage(
                                        id: 4,
                                        catName: 'Bed',
                                      );
                                    },
                                  ));
                                  search.clear();
                                } else if (search.text.trim().toLowerCase() ==
                                        'office' ||
                                    search.text.trim().toLowerCase() ==
                                        'office room') {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return const RoomPage(
                                        id: 5,
                                        catName: 'Office',
                                      );
                                    },
                                  ));
                                  search.clear();
                                } else {
                                  isSearchFound = furnitures.any((furniture) =>
                                      furniture['furName'].toLowerCase() ==
                                      search.text.trim().toLowerCase());
                                  if (isSearchFound) {
                                    final filterFurnitureItems =
                                        furnitures.firstWhere((furniture) =>
                                            furniture['furName']
                                                .toLowerCase() ==
                                            search.text.trim().toLowerCase());
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return DescriptionPage(
                                          id: filterFurnitureItems['id'],
                                          catID: filterFurnitureItems['catID'],
                                          ratings:
                                              filterFurnitureItems['ratings'],
                                          imageUrl:
                                              filterFurnitureItems['imageUrl'],
                                          furName:
                                              filterFurnitureItems['furName'],
                                          price: filterFurnitureItems['price'],
                                          description: filterFurnitureItems[
                                              'description'],
                                          materials:
                                              filterFurnitureItems['materials'],
                                        );
                                      },
                                    ));
                                    search.clear();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Item not Found'),
                                      ),
                                    );
                                    search.clear();
                                  }
                                }
                              }
                            },
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
                              const Spacer(),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return const CategoriesSeeAll();
                                    },
                                  ));
                                },
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
                            height: 10,
                          ),
                          SizedBox(
                            height: 100,
                            child: ListView.builder(
                              itemCount: 3,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final categoryItem = categories[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return CategoryPage(
                                              id: categoryItem['id'],
                                              catName: categoryItem['catName'],
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: Card(
                                      child: Categories(
                                        catName: categoryItem['catName'],
                                        imageUrl: categoryItem['imageUrl'],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 210,
                            child: PageView.builder(
                              controller: _pageController,
                              itemCount: banners.length,
                              itemBuilder: (context, index) {
                                final pageViewItem = banners[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return BannersPage(
                                            id: pageViewItem['id'],
                                            text1: pageViewItem['text1'],
                                            text3: pageViewItem['text3'],
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Card(
                                    child: Banners(
                                      text1: pageViewItem['text1'],
                                      text2: pageViewItem['text2'],
                                      text3: pageViewItem['text3'],
                                      imageUrl: pageViewItem['imageUrl'],
                                    ),
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
                                activeDotColor: Color.fromRGBO(78, 84, 113, 1),
                              ),
                              count: 3,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                'Popular',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const Spacer(),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return const PopularSeeAll();
                                    },
                                  ));
                                },
                                child: const Row(
                                  children: [
                                    Text('See all'),
                                    Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: 16,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GridView.builder(
                            itemCount: furnitures
                                .where((furniture) =>
                                    furniture['isPopular'] == true)
                                .toList()
                                .length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 0.63,
                            ),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final furnitureItem = furnitures
                                  .where((furniture) =>
                                      furniture['isPopular'] == true)
                                  .toList()[index];
                              bool isFavorite = favorites.any((favorite) =>
                                  favorite['id'] == furnitureItem['id']);
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return DescriptionPage(
                                          id: furnitureItem['id'],
                                          catID: furnitureItem['catID'],
                                          ratings: furnitureItem['ratings'],
                                          imageUrl: furnitureItem['imageUrl'],
                                          furName: furnitureItem['furName'],
                                          price: furnitureItem['price'],
                                          description:
                                              furnitureItem['description'],
                                          materials: furnitureItem['materials'],
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Card(
                                  child: Popular(
                                    id: furnitureItem['id'],
                                    catID: furnitureItem['catID'],
                                    imageUrl: furnitureItem['imageUrl'],
                                    furName: furnitureItem['furName'],
                                    price: furnitureItem['price'],
                                    ratings: furnitureItem['ratings'],
                                    description: furnitureItem['description'],
                                    isFavorite: isFavorite,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 190,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return const BannersPage(
                                      id: 1,
                                      text1: 'Sale All Chairs',
                                      text3: '65%',
                                    );
                                  },
                                ));
                              },
                              child: Card(
                                color: const Color.fromRGBO(242, 233, 222, 1),
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Image.asset(
                                        'assets/images/banners/ban_sale.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Sale',
                                            style: TextStyle(
                                              fontSize: 32,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                          ),
                                          Text(
                                            'All chair up to',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '65%',
                                                style: TextStyle(
                                                  fontSize: 28,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'off',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                    ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Rooms',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Furniture for every corners in your home',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 230,
                            child: ListView.builder(
                              itemCount: 3,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final categoriesItem = categories
                                    .where((category) => category['id'] <= 6)
                                    .skip(3)
                                    .toList()[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return RoomPage(
                                              id: categoriesItem['id'],
                                              catName:
                                                  categoriesItem['catName'],
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: Card(
                                      child: Rooms(
                                        imageUrl: categoriesItem['imageUrl'],
                                        catName: categoriesItem['catName'],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
