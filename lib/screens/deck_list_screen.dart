import 'package:flutter/material.dart';
import 'package:picards/screens/deck_detail_screen.dart';
import 'package:picards/widgets/deck_card.dart';

class DeckListScreen extends StatefulWidget {
  const DeckListScreen({super.key});

  @override
  State<DeckListScreen> createState() => _DeckListScreenState();
}

class _DeckListScreenState extends State<DeckListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: DeckCard()),
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
