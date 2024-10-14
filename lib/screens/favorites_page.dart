import 'package:ciphen/constants/cart_similar_products.dart';
import 'package:ciphen/screens/home_page.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return const HomePage();
                                    },
                                  ));
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
                                'My Shopping Bag',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Column(
                                children: List.generate(3, (index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'assets/images/furnitures/sofas/sectional_sofa.png',
                                              fit: BoxFit.cover,
                                              width: 100,
                                              height: 110,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Hello World',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge,
                                                      ),
                                                      const Spacer(),
                                                      Icon(
                                                        Icons.cancel_outlined,
                                                        size: 32,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    'Qty: 1',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .indeterminate_check_box_outlined,
                                                        size: 32,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        '1',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Icon(
                                                        Icons.add_box_outlined,
                                                        size: 32,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                      ),
                                                      const Spacer(),
                                                      Text(
                                                        '\$10',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge
                                                            ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                                  );
                                }),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Furniture that you might like',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const SizedBox(
                                height: 280,
                                child: CartSimilarProducts(),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          'Total',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '\$10',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 70,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.all(16)),
                        child: Text(
                          'Proceed to checkout',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
