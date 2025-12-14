import 'package:flutter/material.dart';
import '../model/weather_model.dart';
import '../repositories/weather_repository.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherRepository _repository = WeatherRepository();

  WeatherModel? weather;
  bool isLoading = false;
  String? error;

  Future<void> fetchWeather(String city) async {
    isLoading = true;
    error = null;
    notifyListeners(); // UI updates

    try {
      weather = await _repository.getWeather(city);
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners(); // UI updates again
  }
}

// The provider becomes the brain of the app

// Provider fetches data from Repository
// Provider manages loading
// Provider handles errors
// UI just listens and displays data

// UI becomes clean and simple
