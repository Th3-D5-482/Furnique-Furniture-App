import 'package:ciphen/constants/banners_cat.dart';
import 'package:flutter/material.dart';

class BannersPage extends StatefulWidget {
  final String text1;
  final String text3;
  const BannersPage({
    super.key,
    required this.text1,
    required this.text3,
  });

  @override
  State<BannersPage> createState() => _BannersPageState();
}

class _BannersPageState extends State<BannersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
              Row(
                children: [
                  Text(
                    widget.text1,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.text3,
                    style: const TextStyle(fontSize: 36),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'off',
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: GridView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.vertical,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.69,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return const Card(
                        child: BannersCat(),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
