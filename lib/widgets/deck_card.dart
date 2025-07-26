import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class DeckCard extends StatefulWidget {
  const DeckCard({super.key});

  @override
  State<DeckCard> createState() => _DeckCardState();
}

class _DeckCardState extends State<DeckCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Ionicons.checkmark,
        size: 40,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(
        'allah ve haramileri ',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      tileColor: Theme.of(context).colorScheme.surface,
      trailing: Icon(Icons.directions_run),
      minVerticalPadding: 20,
      minTileHeight: 100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onTap: () {},
    );
  }
}
