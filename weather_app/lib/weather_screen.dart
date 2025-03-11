import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/additional_info_item.dart';
import 'package:weather_app/hourly_forecast_item.dart';
import 'package:weather_app/secrets.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({ super.key });

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = 'London';
      final res = await http.get(
        Uri.parse('https://api.openweathermap.org/data/2.5/forecast?q=$cityName,uk&APPID=$openWeatherAPIKey'),
      );
      
      final data = jsonDecode(res.body);

      if (data['cod'] != '200') {
        throw data['message'];
      }

      return data;

    } catch (e) {
      throw e.toString();
    }

  }

  @override build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: getCurrentWeather,
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator.adaptive());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data!;

          final currentWeatherData = data['list'][0];

          final currentTemp = currentWeatherData['main']['temp'];
          final currentSky = currentWeatherData['weather'][0]['main'];
          final currentPressure = currentWeatherData['main']['pressure'];
          final currentHumidity = currentWeatherData['main']['humidity'];
          final currentWindSpeed = currentWeatherData['wind']['speed'];

          final vectorforecastData = [...data['list']];
          vectorforecastData.removeAt(0);
          
          final hourlysItems = vectorforecastData.map((fore) {
            dynamic time = fore['dt_txt'];
            time = time.split(' ');
            String wtFore = fore['weather'][0]['main'];
            return HourlyForecastItem(
              time[1],
              time[0],
              fore['main']['temp'].toString(),
              wtFore == 'Clouds' || wtFore == 'Rain'
              ? Icons.cloud
              : Icons.sunny
            );
          });
          

          return Padding(
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
                              Text('$currentTemp K', style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold
                              )),
                              SizedBox(height: 16),
                              Icon(
                                currentSky == 'Clouds' || currentSky == 'Rain'
                                ? Icons.cloud
                                : Icons.sunny,
                                size: 64
                              ),
                              SizedBox(height: 16),
                              Text(currentSky, style: TextStyle(
                                fontSize: 18,
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Hourly Forecast', style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
                const SizedBox(height: 16),
                // Hourly forecast cards
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...hourlysItems
                      // HourlyForecastItem(
                      //   '00:00',
                      //   '301.22',
                      //   Icons.cloud,
                      // ),
                      // HourlyForecastItem(
                      //   '03:00',
                      //   '300.52',
                      //   Icons.sunny,
                      // ),
                      // HourlyForecastItem(
                      //   '06:00',
                      //   '302.22',
                      //   Icons.cloud,
                      // ),
                      // HourlyForecastItem(
                      //   '09:00',
                      //   '300.12',
                      //   Icons.sunny,
                      // ),
                      // HourlyForecastItem(
                      //   '12:00',
                      //   '304.12',
                      //   Icons.cloud,
                      // ),
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
                      currentHumidity.toString()
                    ),
                    AdditionalInfoItem(
                      Icons.air,
                      'Wind Speed',
                      currentWindSpeed.toString()
                    ),
                    AdditionalInfoItem(
                      Icons.beach_access,
                      'Pressure',
                      currentPressure.toString()
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}