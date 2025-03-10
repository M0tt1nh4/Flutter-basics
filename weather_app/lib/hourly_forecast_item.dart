import 'package:flutter/material.dart';

class HourlyForecastItem extends StatelessWidget {
  const HourlyForecastItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 100,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), 
        ),
        child: Column(
          children: [
          Text('3:00', style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          )),
          const SizedBox(height: 8),
         Icon(Icons.cloud),
          const SizedBox(height: 8),
         Text('320.12'),
         ],
        ),
      ),
    );
  }
}