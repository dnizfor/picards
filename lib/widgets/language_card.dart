import 'package:dash_flags/dash_flags.dart';
import 'package:flutter/material.dart';

class LanguageCard extends StatefulWidget {
  const LanguageCard({
    super.key,
    required this.title,
    required this.code,
    required this.onPress,
    this.isSelected = false,
  });
  final String title;
  final String code;
  final Function onPress;
  final bool isSelected;

  @override
  State<LanguageCard> createState() => _LanguageCardState();
}

class _LanguageCardState extends State<LanguageCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 100,
      leading: LanguageFlag(
        language: Language.fromCode(widget.code),
        height: 50,
      ),
      tileColor: Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: widget.isSelected
            ? BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)
            : BorderSide.none,
      ),
      title: Text(
        widget.title,
        style: TextStyle(
          color: widget.isSelected
              ? Theme.of(context).colorScheme.primary
              : Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: widget.isSelected
            ? Theme.of(context).colorScheme.primary
            : Colors.white,
        size: 30,
      ),
      onTap: () => widget.onPress(),
    );
  }
}
