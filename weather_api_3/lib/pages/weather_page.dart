import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class WeatherPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();

    return Scaffold(
      appBar: AppBar(title: Text("Weather App - Level 3")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Enter city",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                provider.fetchWeather(_controller.text);
              },
              child: Text("Get Weather"),
            ),

            SizedBox(height: 30),

            if (provider.isLoading)
              CircularProgressIndicator(),

            if (provider.error != null)
              Text(
                provider.error!,
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),

            if (provider.weather != null)
              Column(
                children: [
                  Text(
                    provider.weather!.cityName,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${provider.weather!.temperature}°C",
                    style: TextStyle(fontSize: 40),
                  ),
                  Text(
                    provider.weather!.description,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
