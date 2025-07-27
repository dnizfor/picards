import 'package:flutter/material.dart';
import 'package:picards/models/deck_model.dart';
import 'package:picards/screens/deck_detail_screen.dart';
import 'package:picards/services/database_service.dart';
import 'package:picards/widgets/deck_card.dart';

class DeckListScreen extends StatefulWidget {
  const DeckListScreen({super.key});

  @override
  State<DeckListScreen> createState() => _DeckListScreenState();
}

class _DeckListScreenState extends State<DeckListScreen> {
  late List<Deck> deckList = [];

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
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => DeckCard(
                key: UniqueKey(),
                deck: deckList[index],
                onDismissed: () =>
                    DatabaseService.deleteDeckById(deckList[index].id!),
              ),
              itemCount: deckList.length,
              separatorBuilder: (context, index) => SizedBox(height: 10),
            ),
          ),
        ],
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
