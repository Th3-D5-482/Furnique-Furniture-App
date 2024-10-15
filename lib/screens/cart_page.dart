import 'package:ciphen/constants/cart_similar_products.dart';
import 'package:ciphen/constants/delete_confirm_box.dart';
import 'package:ciphen/database/cartdb.dart';
import 'package:ciphen/screens/home_page.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<CartPage> {
  late Stream<List<Map<String, dynamic>>> furnitureStream;
  int finalSum = 0;

  @override
  void initState() {
    super.initState();
    furnitureStream = getCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: furnitureStream,
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
          final carts = snapshot.data!;
          return SafeArea(
            child: Column(
              children: [
                Flexible(
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
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
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
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  carts.isNotEmpty
                                      ? Column(
                                          children: List.generate(carts.length,
                                              (index) {
                                            final cartItems = carts[index];
                                            return Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Card(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Row(
                                                    children: [
                                                      Image.network(
                                                        cartItems['imageUrl'],
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
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  cartItems[
                                                                      'furName'],
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyLarge,
                                                                ),
                                                                const Spacer(),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    deleteConfirmBox(
                                                                      cartItems[
                                                                          'id'],
                                                                      context,
                                                                    );
                                                                  },
                                                                  child: Icon(
                                                                    Icons
                                                                        .cancel_outlined,
                                                                    size: 32,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .primary,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              'Qty: ${cartItems['numberInCart']}',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium
                                                                  ?.copyWith(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .secondary,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                  ),
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            Row(
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    if (cartItems[
                                                                            'numberInCart'] >
                                                                        1) {
                                                                      decrementCart(
                                                                        cartItems[
                                                                            'id'],
                                                                      );
                                                                    }
                                                                  },
                                                                  child: Icon(
                                                                    Icons
                                                                        .indeterminate_check_box_outlined,
                                                                    size: 32,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .primary,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  '${cartItems['numberInCart']}',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyLarge,
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    increaseCart(
                                                                      cartItems[
                                                                          'id'],
                                                                    );
                                                                  },
                                                                  child: Icon(
                                                                    Icons
                                                                        .add_box_outlined,
                                                                    size: 32,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .primary,
                                                                  ),
                                                                ),
                                                                const Spacer(),
                                                                Text(
                                                                  '\$${cartItems['totalPrice']}',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyLarge
                                                                      ?.copyWith(
                                                                        fontWeight:
                                                                            FontWeight.bold,
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
                                      : SizedBox(
                                          height: 700,
                                          child: Center(
                                            child: Text(
                                              'Your cart is empty',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ),
                                        )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        carts.isNotEmpty
                            ? SizedBox(
                                width: double.infinity,
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Furniture that you might like',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
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
                            : Container()
                      ],
                    ),
                  ),
                ),
                carts.isNotEmpty
                    ? Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Total',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '\$$finalSum',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
          );
        },
      ),
    );
  }
}
