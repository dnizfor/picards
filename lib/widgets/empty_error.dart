import 'package:flutter/material.dart';

class EmptyError extends StatefulWidget {
  const EmptyError({super.key, required this.title});
  final String title;

  @override
  State<EmptyError> createState() => _EmptyErrorState();
}

class _EmptyErrorState extends State<EmptyError> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.sentiment_dissatisfied, size: 150, color: Colors.grey),
            SizedBox(height: 10),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
