import 'package:flutter/material.dart';
import 'package:picards/providers/feed_provider.dart';
import 'package:picards/utils/enums/practice_type_enum.dart';
import 'package:picards/widgets/deck_tile.dart';
import 'package:picards/widgets/practice_tile.dart';
import 'package:provider/provider.dart';

class FeedScreenDrawer extends StatefulWidget {
  const FeedScreenDrawer({super.key});

  @override
  State<FeedScreenDrawer> createState() => _FeedScreenDrawerState();
}

class _FeedScreenDrawerState extends State<FeedScreenDrawer> {
  @override
  void initState() {
    Provider.of<FeedProvider>(context, listen: false).updateDeckList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final feedProvider = Provider.of<FeedProvider>(context);
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: Text(
              'Pratic:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          PracticeTile(
            value: 'flashcard',
            label: 'Flashcard',
            icon: Icons.collections_bookmark,
            isSelected: feedProvider.practiceType == PracticeType.flashcard,
            onTap: (value) {
              feedProvider.setPracticeType(PracticeType.flashcard);
            },
          ),
          PracticeTile(
            value: 'translate',
            label: 'Translate',
            icon: Icons.language,
            isSelected: feedProvider.practiceType == PracticeType.translate,
            onTap: (value) {
              feedProvider.setPracticeType(PracticeType.translate);
            },
          ),
          PracticeTile(
            value: 'image',
            label: 'Image',
            icon: Icons.image,
            isSelected: feedProvider.practiceType == PracticeType.wordByImage,
            onTap: (value) {
              feedProvider.setPracticeType(PracticeType.wordByImage);
            },
          ),
          PracticeTile(
            value: 'gap_filling',
            label: 'Gap filling',
            icon: Icons.space_bar,
            isSelected: feedProvider.practiceType == PracticeType.gapFilling,
            onTap: (value) {
              feedProvider.setPracticeType(PracticeType.gapFilling);
            },
          ),
          PracticeTile(
            value: 'dialog',
            label: 'Dialog',
            icon: Icons.forum,
            isSelected: feedProvider.practiceType == PracticeType.dialog,
            onTap: (value) {
              feedProvider.setPracticeType(PracticeType.dialog);
            },
          ),

          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: Text(
              'Decks:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: feedProvider.deckList.length,
              itemBuilder: (context, index) => DeckTile(
                value: feedProvider.deckList[index].id.toString(),
                label: feedProvider.deckList[index].name,
                isSelected:
                    feedProvider.selectedDeckId ==
                    feedProvider.deckList[index].id,
                onTap: (value) {
                  feedProvider.setSelectedDeckId(
                    feedProvider.deckList[index].id!,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
