import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // this class stores all values used for UI

  final TextEditingController _controller = TextEditingController(); 
  // reads the text entered by user in TextField.

  final WeatherService _weatherService = WeatherService();
  // Allows UI to call API through WeatherService.

  WeatherModel? weather; // stores the WeatherModel returned from API.
  bool isLoading = false; // loading spinner

  void getWeather() async { // called when user presses the button

    setState(() => isLoading = true);

    try {
      final data = await _weatherService.fetchWeather(_controller.text); // fetches weather data . returns WeatherModel object.
      setState(() {
        weather = data; // updates the UI with new data
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("City not found!")), // API fails, wrong city name
      );
    }

    setState(() => isLoading = false); // stops loading spinner
  }

  @override
  Widget build(BuildContext context) { // builds the page layout
    return Scaffold(
      appBar: AppBar(title: Text("Weather App")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Enter city name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: getWeather,
              child: Text("Get Weather"),
            ),
            const SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator()
                : weather != null
                    ? Column(
                        children: [
                          Text(
                            weather!.cityName,
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${weather!.temperature}°C",
                            style: TextStyle(fontSize: 40),
                          ),
                          Text(
                            weather!.description,
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      )
                    : Container(),
          ],
        ),
      ),
    );
  }
}
