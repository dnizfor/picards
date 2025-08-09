import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:picards/widgets/survey_console.dart';

class SurveyCard extends StatefulWidget {
  const SurveyCard({
    super.key,
    required this.title,
    required this.answer,
    required this.goToNextPage,
    required this.options,
  });
  final String title;
  final String answer;
  final Function goToNextPage;
  final List<Map<String, dynamic>> options;

  @override
  State<SurveyCard> createState() => _SurveyCardState();
}

class _SurveyCardState extends State<SurveyCard> {
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
          child: AutoSizeText(
            widget.title,
            textAlign: TextAlign.center,
            maxLines: 4,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
          ),
        ),
        SurveyConsole(
          answer: widget.answer,
          goToNextPage: widget.goToNextPage,
          options: widget.options,
        ),
      ],
    );
  }
}
