import 'package:flutter/material.dart';

class DeckTile extends StatelessWidget {
  final String value;
  final String label;

  final bool isSelected;
  final ValueChanged<String> onTap;

  const DeckTile({
    super.key,
    required this.value,
    required this.label,

    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          color: isSelected ? Theme.of(context).colorScheme.primary : null,
        ),
      ),
      leading: Icon(
        isSelected ? Icons.egg : Icons.egg_outlined,
        color: isSelected ? Theme.of(context).colorScheme.primary : null,
      ),
      onTap: () => onTap(value),
    );
  }
}
