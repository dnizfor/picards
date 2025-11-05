import 'dart:async';

import 'package:flutter/material.dart';
import 'package:picards/models/deck_model.dart';
import 'package:picards/providers/feed_provider.dart';
import 'package:picards/screens/deck_detail_screen.dart';
import 'package:picards/services/database_service.dart';
import 'package:picards/widgets/draw_card_button.dart';
import 'package:picards/widgets/story_time_button.dart';

import 'package:picards/widgets/deck_card.dart';
import 'package:provider/provider.dart';

class DeckListScreen extends StatefulWidget {
  const DeckListScreen({super.key});

  @override
  State<DeckListScreen> createState() => _DeckListScreenState();
}

class _DeckListScreenState extends State<DeckListScreen> {
  late List<Deck> deckList = [];
  bool isMarathonLoading = false;

  Future<void> loadAllDecks() async {
    final dbDeckList = await DatabaseService.getAllDecks();
    setState(() {
      deckList = dbDeckList;
    });
  }

  @override
  void initState() {
    super.initState();
    loadAllDecks();
  }

  @override
  Widget build(BuildContext context) {
    final feedProvider = Provider.of<FeedProvider>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          children: [
            StoryTimeButton(),
            SizedBox(height: 15),
            DrawCardButton(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  Text('Decks:', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => DeckCard(
                  key: UniqueKey(),
                  deck: deckList[index],
                  onDismissed: () {
                    DatabaseService.deleteDeckById(deckList[index].id!);
                    feedProvider.updateDeckList();
                  },
                ),
                itemCount: deckList.length,
                separatorBuilder: (context, index) => SizedBox(height: 10),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DeckDetailScreen()),
        ),
        shape: CircleBorder(),
        child: Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }
}
