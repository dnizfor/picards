import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:picards/models/flashcard_model.dart';
import 'package:picards/providers/language_provider.dart';
import 'package:picards/services/database_service.dart';
import 'package:picards/services/vertex_ai_service.dart';
import 'package:picards/utils/utils.dart';
import 'package:picards/widgets/story_card.dart';
import 'package:provider/provider.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({super.key, required this.writeNewStory});
  final bool writeNewStory;

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  List<String> story = [];
  bool loading = false;
  @override
  void initState() {
    final String targetLanguageCode = Provider.of<LanguageProvider>(
      context,
      listen: false,
    ).targetLanguageCode;
    getStory(targetLanguageCode);
    super.initState();
  }

  Future<void> getStory(String targetLangCode) async {
    if (widget.writeNewStory) {
      setState(() {
        loading = true;
      });
      List<Flashcard> flashcardList =
          await DatabaseService.getRandomFlashcards();

      String response = await VertexAiService.sendRequestForCreateStory(
        VertexAiService.createStoryPropmt(targetLangCode, flashcardList),
      );
      final List<String> sentenceList = Utils.splitIntoSentences(
        json.decode(response)['story'],
      );
      if (!mounted) return;
      setState(() {
        story = sentenceList;
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Story Time!',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: loading
          ? Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                size: 100,
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          : Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemCount: story.length,
                itemBuilder: (context, index) => StoryCard(title: story[index]),
              ),
            ),
    );
  }
}
