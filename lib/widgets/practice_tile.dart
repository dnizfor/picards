import 'package:flutter/material.dart';

class PracticeTile extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final bool isSelected;
  final ValueChanged<String> onTap;

  const PracticeTile({
    super.key,
    required this.value,
    required this.label,
    required this.icon,
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
      trailing: Icon(
        icon,
        color: isSelected ? Theme.of(context).colorScheme.primary : null,
      ),
      onTap: () => onTap(value),
    );
  }
}
