import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:picards/models/deck_model.dart';
import 'package:picards/models/flashcard_model.dart';
import 'package:picards/services/database_service.dart';
import 'package:picards/utils/enums/practice_type_enum.dart';
import 'package:picards/utils/utils.dart';
import 'package:picards/widgets/chat_card.dart';
import 'package:picards/widgets/empty_error.dart';
import 'package:picards/widgets/flashcard_container.dart';
import 'package:picards/widgets/gap_filling_card.dart';
import 'package:picards/widgets/image_test_card.dart';
import 'package:picards/widgets/practice_success_widget.dart';
import 'package:picards/widgets/survey_card.dart';

class MarathonScreen extends StatefulWidget {
  const MarathonScreen({super.key, required this.deck});
  final Deck deck;

  @override
  State<MarathonScreen> createState() => _MarathonScreenState();
}

class _MarathonScreenState extends State<MarathonScreen> {
  final PageController pageController = PageController();
  int currentPageIndex = 0;
  PracticeType practiceType = PracticeType.flashcard;
  List<Flashcard> flashcards = [];
  bool showPassButton = false;
  bool loading = true;

  Color getIconColor(PracticeType practiceTyp) {
    switch (practiceTyp) {
      case PracticeType.flashcard:
        return Colors.grey;
      case PracticeType.translate:
        return Theme.of(context).colorScheme.error;
      case PracticeType.wordByImage:
        return Theme.of(context).colorScheme.primary;
      case PracticeType.gapFilling:
        return Theme.of(context).colorScheme.tertiary;
      default:
        return Colors.black;
    }
  }

  void passPractice() {
    switch (practiceType) {
      case PracticeType.flashcard:
        setState(() {
          practiceType = PracticeType.translate;
        });
        break;
      case PracticeType.translate:
        setState(() {
          practiceType = PracticeType.wordByImage;
        });
        break;

      case PracticeType.wordByImage:
        setState(() {
          practiceType = PracticeType.gapFilling;
        });
        break;
      case PracticeType.gapFilling:
        showDialog(
          context: context,
          builder: (context) => PracticeSuccessWidget(),
        );
        break;
      default:
    }
    pageController.jumpToPage(0);
    setState(() {
      showPassButton = false;
    });
  }

  void goToNextPage(int listLength) {
    if (flashcards.length - 1 == currentPageIndex) {
      setState(() {
        showPassButton = true;
      });
      return;
    }
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    FocusScope.of(context).unfocus();
  }

  List<Map<String, dynamic>> getOptions(String title, String optionField) {
    final options = Utils.createOptions(title, flashcards, optionField);
    return options;
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final results = await Future.wait([
        DatabaseService.getFlashcardsByDeckId(widget.deck.id!),
        Future.delayed(const Duration(seconds: 2)),
      ]);

      final flashcardList = results[0];

      setState(() {
        flashcards = flashcardList;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: Lottie.asset(
            'assets/lotties/marathon.json',
            fit: BoxFit.cover,
            width: 200,
          ),
        ),
      );
    }
    return (flashcards.length < 3)
        ? Scaffold(
            appBar: AppBar(),
            body: EmptyError(
              title:
                  "There are not enough words in the deck. There must be at least 3 words. Please add a word!",
            ),
          )
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: LinearPercentIndicator(
                animation: true,
                animationDuration: 1000,
                animateFromLastPercent: true,
                lineHeight: 14.0,
                percent:
                    (currentPageIndex + 1) /
                    (flashcards.isNotEmpty ? flashcards.length : 1),
                backgroundColor: Colors.grey,
                barRadius: Radius.circular(15),
                progressColor: Theme.of(context).colorScheme.primary,
                trailing: Icon(
                  Ionicons.heart,
                  color: getIconColor(practiceType),
                ),
              ),
            ),
            floatingActionButton: currentPageIndex == flashcards.length - 1
                ? (practiceType == PracticeType.flashcard
                      ? FloatingActionButton(
                          onPressed: passPractice,
                          shape: const CircleBorder(),
                          child: const Icon(
                            Ionicons.chevron_forward,
                            color: Colors.white,
                            size: 30,
                          ),
                        )
                      : (showPassButton
                            ? FloatingActionButton(
                                onPressed: passPractice,
                                shape: const CircleBorder(),
                                child: const Icon(
                                  Ionicons.chevron_forward,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              )
                            : SizedBox()))
                : SizedBox(),
            body: Padding(
              padding: EdgeInsetsGeometry.all(20),
              child: PageView.builder(
                physics: practiceType != PracticeType.flashcard
                    ? NeverScrollableScrollPhysics()
                    : AlwaysScrollableScrollPhysics(),
                controller: pageController,
                onPageChanged: (index) => setState(() {
                  currentPageIndex = index;
                }),
                itemBuilder: (context, index) {
                  final Flashcard card = flashcards[index];
                  if (practiceType == PracticeType.flashcard) {
                    return FlashcardContainer(
                      word: card.word!,
                      mean: card.mean!,
                      example: card.example!,
                      exampleMean: card.exampleMean!,
                      imagePath: card.imagePath!,
                    );
                  } else if (practiceType == PracticeType.translate) {
                    return SurveyCard(
                      title: card.word!,
                      answer: card.mean!,
                      goToNextPage: () => goToNextPage(flashcards.length),
                      options: getOptions(card.mean!, "mean"),
                    );
                  } else if (practiceType == PracticeType.wordByImage) {
                    return ImageTestCard(
                      goToNextPage: () => goToNextPage(flashcards.length),
                      imagePath: card.imagePath!,
                      options: getOptions(card.word!, "word"),
                    );
                  } else if (practiceType == PracticeType.gapFilling) {
                    return GapFillingCard(
                      word: card.word!,
                      answer: card.word!,
                      goToNextPage: () => goToNextPage(flashcards.length),
                      options: getOptions(card.word!, "word"),
                    );
                  } else if (practiceType == PracticeType.dialog) {
                    return ChatCard(
                      word: card.word!,
                      goToNextPage: () => goToNextPage(flashcards.length),
                    );
                  } else {
                    return Container();
                  }
                },
                itemCount: flashcards.length,
                scrollDirection: Axis.vertical,
              ),
            ),
          );
  }
}
