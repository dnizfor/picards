import 'package:flutter/material.dart';
import 'package:picards/providers/deck_detail_provider.dart';
import 'package:picards/widgets/vocabulary_card.dart';
import 'package:provider/provider.dart';

class DeckDetailScreen extends StatefulWidget {
  const DeckDetailScreen({super.key});

  @override
  State<DeckDetailScreen> createState() => _DeckDetailScreenState();
}

class _DeckDetailScreenState extends State<DeckDetailScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        // onPressed: () => context.read<DeckDetailProvider>().addEmptyFlashcard(),
        onPressed: () {},
        shape: CircleBorder(),
        child: Icon(Icons.add, color: Colors.white, size: 30),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: TextField(
                  // onChanged: (value) =>
                  //     context.read<DeckDetailProvider>().setDeckName(value),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    hintText: "deck name",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  vertical: 30,
                  horizontal: 5,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Cards:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),

              VocabularyCard(),
            ],
          ),
        ),
      ),
    );
  }
}
