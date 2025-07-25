import 'package:flutter/material.dart';

class ArrowForwardButton extends StatefulWidget {
  const ArrowForwardButton({
    super.key,
    required this.title,
    required this.onTap,
  });
  final String title;
  final Function onTap;

  @override
  State<ArrowForwardButton> createState() => _ArrowForwardButtonState();
}

class _ArrowForwardButtonState extends State<ArrowForwardButton> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 100,
      tileColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        widget.title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 30),
      onTap: () => widget.onTap(),
    );
  }
}
