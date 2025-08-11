import 'package:flutter/material.dart';
import 'package:picards/models/flashcard_model.dart';
import 'package:picards/providers/feed_provider.dart';
import 'package:picards/utils/enums/practice_type_enum.dart';
import 'package:picards/utils/utils.dart';
import 'package:picards/widgets/chat_card.dart';
import 'package:picards/widgets/empty_error.dart';
import 'package:picards/widgets/feed_screen_drawer.dart';
import 'package:picards/widgets/flashcard_container.dart';
import 'package:picards/widgets/image_test_card.dart';
import 'package:picards/widgets/survey_card.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final PageController pageController = PageController();

  void goToNextPage() {
    FocusScope.of(context).unfocus();

    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  List<Map<String, dynamic>> getOptions(
    FeedProvider provider,
    String title,
    String optionField,
  ) {
    final flashcards = provider.flashcardList;
    final options = Utils.createOptions(title, flashcards, optionField);
    return options;
  }

  @override
  Widget build(BuildContext context) {
    final feedProvider = Provider.of<FeedProvider>(context);
    return Scaffold(
      drawerEdgeDragWidth: MediaQuery.of(context).size.width / 2,
      drawer: FeedScreenDrawer(),
      body: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: feedProvider.flashcardList.isEmpty
            ? EmptyError(
                title:
                    "There are not enough words in the deck. Please add a word!",
              )
            : (feedProvider.practiceType != PracticeType.flashcard &&
                  feedProvider.practiceType != PracticeType.dialog &&
                  feedProvider.flashcardList.length < 3)
            ? EmptyError(
                title:
                    "There are not enough words in the deck. There must be at least 3 words. Please add a word!",
              )
            : PageView.builder(
                controller: pageController,
                itemBuilder: (context, index) {
                  final Flashcard card = feedProvider.flashcardList[index];
                  if (feedProvider.practiceType == PracticeType.flashcard) {
                    return FlashcardContainer(
                      word: card.word!,
                      mean: card.mean!,
                      example: card.example!,
                      exampleMean: card.exampleMean!,
                      imagePath: card.imagePath!,
                    );
                  } else if (feedProvider.practiceType ==
                      PracticeType.translate) {
                    return SurveyCard(
                      title: card.word!,
                      answer: card.mean!,
                      goToNextPage: goToNextPage,
                      options: getOptions(feedProvider, card.mean!, "mean"),
                    );
                  } else if (feedProvider.practiceType ==
                      PracticeType.wordByImage) {
                    return ImageTestCard(
                      goToNextPage: goToNextPage,
                      imagePath: card.imagePath!,
                      options: getOptions(feedProvider, card.word!, "word"),
                    );
                  } else if (feedProvider.practiceType ==
                      PracticeType.gapFilling) {
                    return SurveyCard(
                      title: card.word!,
                      answer: card.mean!,
                      goToNextPage: goToNextPage,
                      options: getOptions(feedProvider, card.word!, "word"),
                    );
                  } else if (feedProvider.practiceType == PracticeType.dialog) {
                    return ChatCard(
                      word: card.word!,
                      goToNextPage: goToNextPage,
                    );
                  } else {
                    return Container();
                  }
                },
                itemCount: feedProvider.flashcardList.length,
                scrollDirection: Axis.vertical,
              ),
      ),
    );
  }
}
