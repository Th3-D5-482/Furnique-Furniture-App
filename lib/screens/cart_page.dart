import 'package:ciphen/constants/cart_items.dart';
import 'package:ciphen/constants/items_like_product.dart';
import 'package:ciphen/database/cartdb.dart';
import 'package:ciphen/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CartPage extends StatefulWidget {
  final int currentPage;
  const CartPage({
    super.key,
    required this.currentPage,
  });

  @override
  State<CartPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<CartPage> {
  late Stream<List<Map<String, dynamic>>> furnitureStream;
  num finalSum = 0;
  final formatter = NumberFormat('#,##0');

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
          finalSum = carts.fold(0, (sum, item) => sum + item['totalPrice']);
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
                                          return const HomePage(
                                            emailID: '',
                                            password: '',
                                          );
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
                                              child: CartItems(
                                                id: cartItems['id'],
                                                numberInCart:
                                                    cartItems['numberInCart'],
                                                totalPrice:
                                                    cartItems['totalPrice'],
                                                imageUrl: cartItems['imageUrl'],
                                                furName: cartItems['furName'],
                                                currentPage: widget.currentPage,
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
                                                  .bodyLarge,
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
                            ? const SizedBox(
                                width: double.infinity,
                                child: ItemsLikeProduct(),
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
                                    '\$${formatter.format(finalSum)}',
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
