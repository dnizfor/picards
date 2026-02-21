import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:picards/models/flashcard_model.dart';
import 'package:picards/providers/feed_provider.dart';
import 'package:picards/utils/enums/practice_type_enum.dart';
import 'package:picards/utils/utils.dart';
import 'package:picards/widgets/chat_card.dart';
import 'package:picards/widgets/empty_error.dart';
import 'package:picards/widgets/feed_screen_drawer.dart';
import 'package:picards/widgets/flashcard_container.dart';
import 'package:picards/widgets/gap_filling_card.dart';
import 'package:picards/widgets/image_test_card.dart';
import 'package:picards/widgets/survey_card.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final PageController pageController = PageController();
  int currentPageIndex = 0;
  bool showDrawerAnimation = false;

  final Map<int, List<Map<String, dynamic>>> _optionsCache = {};

  void goToNextPage(int listLength) {
    FocusScope.of(context).unfocus();
    if (currentPageIndex == listLength - 1) {
      pageController.animateToPage(
        0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return;
    }
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  List<Map<String, dynamic>> getOptions(
    FeedProvider provider,
    int index,
    String title,
    String optionField,
  ) {
    // Eğer cache varsa direkt geri dön
    if (_optionsCache.containsKey(index)) {
      return _optionsCache[index]!;
    }

    // Yoksa üret, cache'e ekle ve geri dön
    final flashcards = provider.flashcardList;
    final options = Utils.createOptions(title, flashcards, optionField);

    _optionsCache[index] = options;
    return options;
  }

  @override
  void initState() {
    checkDrawerAnimationStatus();
    super.initState();
  }

  Future<void> checkDrawerAnimationStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? showDrawerAnimationData = prefs.getBool('showDrawerAnimation');
    if (showDrawerAnimationData == null) {
      setState(() {
        showDrawerAnimation = true;
      });
    }
  }

  Future<void> disableDrawerAnimation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('showDrawerAnimation', false);
    setState(() {
      showDrawerAnimation = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final feedProvider = Provider.of<FeedProvider>(context, listen: true);

    return Scaffold(
      onDrawerChanged: (isOpened) {
        if (showDrawerAnimation && feedProvider.flashcardList.isNotEmpty) {
          disableDrawerAnimation();
        }
      },
      drawerEdgeDragWidth: MediaQuery.of(context).size.width / 2,
      drawer: FeedScreenDrawer(),
      appBar: feedProvider.flashcardList.isNotEmpty
          ? AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: LinearPercentIndicator(
                animation: true,
                animationDuration: 1000,
                animateFromLastPercent: true,
                lineHeight: 14.0,
                percent:
                    (currentPageIndex + 1) /
                    (feedProvider.flashcardList.isNotEmpty
                        ? feedProvider.flashcardList.length
                        : 1),
                backgroundColor: Colors.grey,
                barRadius: Radius.circular(15),
                progressColor: Theme.of(context).colorScheme.primary,
                trailing: Icon(Ionicons.heart),
              ),
            )
          : AppBar(automaticallyImplyLeading: false),

      body: Stack(
        children: [
          Padding(
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
                    onPageChanged: (index) => setState(() {
                      currentPageIndex = index;
                    }),
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
                          goToNextPage: () =>
                              goToNextPage(feedProvider.flashcardList.length),
                          options: getOptions(
                            feedProvider,
                            index,
                            card.mean!,
                            "mean",
                          ),
                        );
                      } else if (feedProvider.practiceType ==
                          PracticeType.wordByImage) {
                        return ImageTestCard(
                          goToNextPage: () =>
                              goToNextPage(feedProvider.flashcardList.length),
                          imagePath: card.imagePath!,
                          options: getOptions(
                            feedProvider,
                            index,
                            card.word!,
                            "word",
                          ),
                        );
                      } else if (feedProvider.practiceType ==
                          PracticeType.gapFilling) {
                        return GapFillingCard(
                          word: card.word!,
                          answer: card.word!,
                          goToNextPage: () =>
                              goToNextPage(feedProvider.flashcardList.length),
                          options: getOptions(
                            feedProvider,
                            index,
                            card.word!,
                            "word",
                          ),
                        );
                      } else if (feedProvider.practiceType ==
                          PracticeType.dialog) {
                        return ChatCard(
                          word: card.word!,
                          goToNextPage: () =>
                              goToNextPage(feedProvider.flashcardList.length),
                        );
                      } else {
                        return Container();
                      }
                    },
                    itemCount: feedProvider.flashcardList.length,
                    scrollDirection: Axis.vertical,
                  ),
          ),
          showDrawerAnimation && feedProvider.flashcardList.isNotEmpty
              ? Align(
                  alignment: Alignment.centerLeft,
                  child: Lottie.asset(
                    'assets/lotties/swipe_right_animation.json',
                    repeat: true,
                    width: 400,
                    fit: BoxFit.fitWidth,
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
