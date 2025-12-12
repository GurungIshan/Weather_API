import 'package:flutter/material.dart';
import '../repositories/weather_repository.dart';
import '../states/weather_state.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController _controller = TextEditingController();
  final WeatherRepository _repository = WeatherRepository();

  WeatherState state = WeatherState();

  void fetchWeather() async {
    setState(() => state = WeatherState.loading());

    try {
      final model = await _repository.getWeather(_controller.text);
      setState(() {
        state = WeatherState.success(model);
      });
    } catch (e) {
      setState(() {
        state = WeatherState.error(e.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Weather App Level Up")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
              onPressed: fetchWeather,
              child: Text("Check Weather"),
            ),

            SizedBox(height: 20),

            Expanded(child: Center(child: buildStateUI())),
          ],
        ),
      ),
    );
  }

  Widget buildStateUI() {
    if (state.isLoading) {
      return CircularProgressIndicator();
    }

    if (state.error != null) {
      return Text(
        state.error!,
        style: TextStyle(color: Colors.red, fontSize: 18),
        textAlign: TextAlign.center,
      );
    }

    if (state.data != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            state.data!.cityName,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Text("${state.data!.temperature}°C", style: TextStyle(fontSize: 40)),
          Text(state.data!.description, style: TextStyle(fontSize: 20)),
        ],
      );
    }

    return Text("Enter a city to get started");
  }
}
