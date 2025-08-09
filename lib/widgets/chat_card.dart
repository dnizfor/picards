import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatefulWidget {
  const ChatCard({super.key});

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 5 * MediaQuery.of(context).size.height / 12,
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(15),
          ),
          child: AutoSizeText(
            "hello how __ you ?",
            textAlign: TextAlign.center,
            maxLines: 4,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
          ),
        ),
        // SurveyConsole(answer: "duck"),
      ],
    );
  }
}
