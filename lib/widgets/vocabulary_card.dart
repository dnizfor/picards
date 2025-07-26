import 'package:flutter/material.dart';

class VocabularyCard extends StatelessWidget {
  const VocabularyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.surface,
      ),
      padding: EdgeInsets.all(15),

      child: Column(
        children: [
          TextField(
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              hintText: "word",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
          ),
          Divider(color: Theme.of(context).colorScheme.primary),
          TextField(
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              hintText: "mean",
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
