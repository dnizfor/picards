import 'package:flutter/material.dart';
import 'package:picards/widgets/option_card.dart';

class SurveyConsole extends StatefulWidget {
  const SurveyConsole({
    super.key,
    required this.answer,
    required this.goToNextPage,
    required this.options,
  });
  final String answer;
  final Function goToNextPage;
  final List<Map<String, dynamic>> options;

  @override
  State<SurveyConsole> createState() => _SurveyConsoleState();
}

class _SurveyConsoleState extends State<SurveyConsole> {
  bool isSelectionMade = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              reverse: true,
              itemBuilder: (context, index) => OptionCard(
                title: widget.options[index]['option'],
                isSelectionMade: isSelectionMade,
                select: () => setState(() {
                  isSelectionMade = true;
                }),
                isAnswer: widget.options[index]['answer'],
                goToNextPage: widget.goToNextPage,
              ),
              separatorBuilder: (context, index) => SizedBox(height: 3),
              itemCount: widget.options.length,
            ),
          ),
        ],
      ),
    );
  }
}
