import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../bloc/weather_state.dart';

class WeatherPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<WeatherBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Weather App - Bloc")),
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
                bloc.add(FetchWeather(_controller.text));
              },
              child: Text("Get Weather"),
            ),

            SizedBox(height: 30),

            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherInitial) {
                  return Text("Enter a city to start");
                } else if (state is WeatherLoading) {
                  return CircularProgressIndicator();
                } else if (state is WeatherLoaded) {
                  return Column(
                    children: [
                      Text(state.weather.cityName,
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold)),
                      Text("${state.weather.temperature}°C",
                          style: TextStyle(fontSize: 40)),
                      Text(state.weather.description,
                          style: TextStyle(fontSize: 20)),
                    ],
                  );
                } else if (state is WeatherError) {
                  return Text(state.message,
                      style: TextStyle(color: Colors.red, fontSize: 18));
                }

                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
