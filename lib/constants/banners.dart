import 'package:flutter/material.dart';

class Banners extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;
  final String imageUrl;
  const Banners({
    super.key,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          imageUrl,
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text1,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                text2,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    text3,
                    style: const TextStyle(
                      fontSize: 36,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'off',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'See all',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
