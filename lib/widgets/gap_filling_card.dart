import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:picards/providers/language_provider.dart';
import 'package:picards/services/vertex_ai_service.dart';
import 'package:picards/widgets/survey_console.dart';
import 'package:provider/provider.dart';

class GapFillingCard extends StatefulWidget {
  const GapFillingCard({
    super.key,
    required this.word,
    required this.answer,
    required this.goToNextPage,
    required this.options,
  });
  final String word;
  final String answer;
  final Function goToNextPage;
  final List<Map<String, dynamic>> options;

  @override
  State<GapFillingCard> createState() => _GapFillingCardState();
}

class _GapFillingCardState extends State<GapFillingCard> {
  String title = '';
  bool loading = false;
  @override
  void initState() {
    final String targetLanguage = Provider.of<LanguageProvider>(
      context,
      listen: false,
    ).targetLanguageCode;

    getTitle(targetLanguage, widget.word);
    super.initState();
  }

  Future<void> getTitle(targetLanguage, word) async {
    setState(() {
      loading = true;
    });
    final String response = await VertexAiService.sendRequestForGapFillingText(
      VertexAiService.createGapFillingTextPropmt(targetLanguage, word),
    );

    final String newTitle = json.decode(response)['text'];
    if (!mounted) return;

    setState(() {
      loading = false;
      title = newTitle;
    });
  }

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
          child: loading
              ? LoadingAnimationWidget.staggeredDotsWave(
                  color: Theme.of(context).colorScheme.primary,
                  size: 70,
                )
              : AutoSizeText(
                  title,
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
