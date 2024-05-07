import 'package:flutter/material.dart';

class RowItems extends StatelessWidget {
  const RowItems({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
  });
  final IconData icon;
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}
