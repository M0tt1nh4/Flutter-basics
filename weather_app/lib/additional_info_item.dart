import 'package:flutter/material.dart';

class AdditionalInfoItem extends StatelessWidget {
  const AdditionalInfoItem(this.icon, this.text, this.value, { super.key });

  final IconData icon;
  final String text;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 32),
        const SizedBox(height: 8),
        Text(text, style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        Text(value, style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        )),
      ],
    );
  }
}