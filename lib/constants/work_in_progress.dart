import 'package:flutter/material.dart';

class WorkInProgress extends StatelessWidget {
  const WorkInProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.construction_rounded,
            size: 128,
          ),
          Text(
            'Project: Ciphen',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Work in progress',
            style: TextStyle(
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }
}
