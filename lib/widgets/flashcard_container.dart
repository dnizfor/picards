import 'dart:io';

import 'package:flutter/material.dart';

class FlashcardContainer extends StatefulWidget {
  const FlashcardContainer({
    super.key,
    required this.word,
    required this.mean,
    required this.example,
    required this.exampleMean,
    required this.imagePath,
  });
  final String word;
  final String mean;
  final String example;
  final String exampleMean;
  final String imagePath;

  @override
  State<FlashcardContainer> createState() => _FlashcardContainerState();
}

class _FlashcardContainerState extends State<FlashcardContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsetsGeometry.all(20),
        child: Column(
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(15),
                  child: Image.file(File(widget.imagePath), fit: BoxFit.cover),
                ),
                Text(
                  widget.word,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.mean,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        widget.example,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        widget.exampleMean,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
