import 'package:flutter/material.dart';
import 'package:picards/providers/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';
import 'package:typewritertext/typewritertext.dart';

class StoryCard extends StatefulWidget {
  const StoryCard({super.key, required this.title});
  final String title;

  @override
  State<StoryCard> createState() => _StoryCardState();
}

class _StoryCardState extends State<StoryCard> {
  String subtitle = '';
  bool loading = false;

  void onExpansionChanged(bool value, LanguageProvider provider) async {
    if (value && subtitle == '' && !loading) {
      setState(() {
        loading = true;
      });

      final nativeLanguageCode = provider.nativeLanguageCode;
      final targetLanguageCode = provider.targetLanguageCode;

      final translator = GoogleTranslator();
      var translation = await translator.translate(
        widget.title,
        from: targetLanguageCode,
        to: nativeLanguageCode,
      );

      setState(() {
        loading = false;
        subtitle = translation.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return ExpansionTile(
      onExpansionChanged: (value) =>
          onExpansionChanged(value, languageProvider),
      tilePadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      title: Text(widget.title),
      backgroundColor: Theme.of(context).colorScheme.surface,
      collapsedBackgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      children: [
        loading
            ? Container(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
                alignment: Alignment.centerLeft,
                child: TypeWriter.text(
                  '....',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.start,
                  duration: const Duration(milliseconds: 300),
                  repeat: true,
                ),
              )
            : ListTile(
                contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                title: Text(subtitle, style: TextStyle(color: Colors.grey)),
              ),
      ],
    );
  }
}
