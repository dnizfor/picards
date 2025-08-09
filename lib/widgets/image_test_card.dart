import 'dart:io';

import 'package:flutter/material.dart';
import 'package:picards/widgets/survey_console.dart';

class ImageTestCard extends StatefulWidget {
  const ImageTestCard({
    super.key,
    required this.goToNextPage,
    required this.options,
    required this.imagePath,
  });
  final Function goToNextPage;
  final List<Map<String, dynamic>> options;
  final String imagePath;

  @override
  State<ImageTestCard> createState() => _ImageTestCardState();
}

class _ImageTestCardState extends State<ImageTestCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 5 * MediaQuery.of(context).size.height / 12,
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(15),
            child: Image.file(File(widget.imagePath), fit: BoxFit.cover),
          ),
        ),
        SurveyConsole(
          answer: "duck",
          goToNextPage: widget.goToNextPage,
          options: widget.options,
        ),
      ],
    );
  }
}
