import 'package:flutter/material.dart';

class VocabularyCard extends StatefulWidget {
  const VocabularyCard({
    super.key,
    required this.onDismissed,
    required this.onChangedWord,
    required this.onChangedMean,
    required this.word,
    required this.mean,
  });
  final Function onDismissed;
  final Function onChangedWord;
  final Function onChangedMean;
  final String word;
  final String mean;

  @override
  State<VocabularyCard> createState() => _VocabularyCardState();
}

class _VocabularyCardState extends State<VocabularyCard> {
  late TextEditingController _wordController;
  late TextEditingController _meanController;

  @override
  void initState() {
    super.initState();

    _wordController = TextEditingController(text: widget.word);
    _meanController = TextEditingController(text: widget.mean);
  }

  @override
  void dispose() {
    _wordController.dispose();
    _meanController.dispose();
    super.dispose();
  }

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
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.surface,
        ),
        padding: EdgeInsets.all(15),

        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return '';
                }
                return null;
              },
              controller: _wordController,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              onChanged: (value) => widget.onChangedWord(value),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                hintText: "word",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
            Divider(color: Theme.of(context).colorScheme.primary),
            TextFormField(
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return '';
                }
                return null;
              },
              controller: _meanController,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              onChanged: (value) => widget.onChangedMean(value),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                hintText: "mean",
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
