import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:picards/models/deck_model.dart';
import 'package:picards/screens/deck_detail_screen.dart';
import 'package:picards/screens/marathon_screen.dart';

class DeckCard extends StatefulWidget {
  const DeckCard({super.key, required this.deck, required this.onDismissed});
  final Deck deck;
  final Function onDismissed;

  @override
  State<DeckCard> createState() => _DeckCardState();
}

class _DeckCardState extends State<DeckCard> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: widget.key!,
      onDismissed: (direction) => widget.onDismissed(),
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.error,
        ),
        padding: EdgeInsets.all(15),
      ),
      child: ListTile(
        leading: Icon(
          Ionicons.egg_outline,
          size: 40,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          widget.deck.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        tileColor: Theme.of(context).colorScheme.surface,
        trailing: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MarathonScreen(deck: widget.deck),
              ),
            );
          },
          icon: Icon(Icons.directions_run),
          iconSize: 30,
        ),
        minTileHeight: 100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DeckDetailScreen(deck: widget.deck),
          ),
        ),
      ),
    );
  }
}
