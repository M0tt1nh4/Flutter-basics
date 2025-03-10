import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/additional_info_item.dart';
import 'package:weather_app/hourly_forecast_item.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({ super.key });

  

  @override build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              print('refresh');
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // main card
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 10.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text('300 °F', style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold
                          )),
                          SizedBox(height: 16),
                          Icon(Icons.cloud, size: 64),
                          SizedBox(height: 16),
                          Text('Rain', style: TextStyle(
                            fontSize: 16,
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Weather Forecast', style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            )),
            const SizedBox(height: 16),
            // weather forecast cards
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  HourlyForecastItem(),
                  HourlyForecastItem(),
                  HourlyForecastItem(),
                  HourlyForecastItem(),
                  HourlyForecastItem(),
                ],  
              ),
            ),
            const SizedBox(height: 20),
            // additional information
            const Text('Additional Information', style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            )),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AdditionalInfoItem(
                  Icons.water_drop,
                  'Humidity',
                  94
                ),
                AdditionalInfoItem(
                  Icons.air,
                  'Wind Speed',
                  7.67
                ),
                AdditionalInfoItem(
                  Icons.beach_access,
                  'Pressure',
                  1006
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}