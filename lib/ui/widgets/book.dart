import 'package:flutter/material.dart';

class Book extends StatelessWidget {
  const Book({
    super.key,
    required this.id,
    required this.title,
    required this.description,
  });

  final int id;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 231, 231, 234),
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(description),
        ],
      ),
    );
  }
}
