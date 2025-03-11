import 'package:flutter/material.dart';

class HourlyForecastItem extends StatelessWidget {
  const HourlyForecastItem(
    this.time,
    this.date,
    this.temperature,
    this.icon,
    {
      super.key,
  });

  final String time;
  final String date;
  final String temperature;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
  dynamic finalDate = date.split('-');
  finalDate = '${finalDate[2]}/${finalDate[1]}';
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
          Text(time, style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          )),
          Text(finalDate),
          const SizedBox(height: 8),
         Icon(icon),
          const SizedBox(height: 8),
         Text(temperature, style: TextStyle(
          fontSize: 16
         )),
         ],
        ),
      ),
    );
  }
}