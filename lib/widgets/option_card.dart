import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class OptionCard extends StatefulWidget {
  const OptionCard({
    super.key,
    required this.isSelectionMade,
    required this.select,
    required this.isAnswer,
    required this.title,
    required this.goToNextPage,
  });
  final bool isSelectionMade;
  final bool isAnswer;
  final Function select;
  final String title;
  final Function goToNextPage;

  @override
  State<OptionCard> createState() => _OptionCardState();
}

class _OptionCardState extends State<OptionCard> {
  bool isSelected = false;

  AudioPlayer player = AudioPlayer();

  Future<void> playWrongSound() async {
    await player.play(AssetSource('sounds/error_effect.mp3'));
  }

  Future<void> playCorrectSound() async {
    await player.play(AssetSource('sounds/success_effect.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.isSelectionMade
          ? null
          : () async {
              setState(() {
                isSelected = true;
              });
              widget.select();
              if (widget.isAnswer) {
                playCorrectSound();
              } else {
                playWrongSound();
              }
              await Future.delayed(Duration(seconds: 1));
              widget.goToNextPage();
            },
      hoverColor: Colors.grey,
      borderRadius: BorderRadius.circular(15),
      child: Ink(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 9,
        decoration: BoxDecoration(
          color: !widget.isSelectionMade
              ? Theme.of(context).colorScheme.primary
              : widget.isAnswer
              ? Theme.of(context).colorScheme.tertiary
              : isSelected
              ? Theme.of(context).colorScheme.error
              : Colors.grey,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            widget.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
      ),
    );
  }
}
