import 'dart:convert'; // convert JSON string
import 'package:http/http.dart' as http; // the library to make HTTP requests
import '../models/weather_model.dart'; // used to convert JSON data into WeatherModel

class WeatherService {
  // all weather related API functions will be here
  final String apiKey = "970a152b7436320503e35de99d102fab";
  final String baseURL = "https://api.openweathermap.org/data/2.5/weather";

  Future<WeatherModel> fetchWeather(String city) async {
    final url = Uri.parse("$baseURL?q=$city&appid=$apiKey&units=metric");
    // converts a string into a usable URL.
    // https://api.openweathermap.org/data/2.5/weather?q=Kathmandu&appid=YOUR_KEY&units=metric

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    }else{
      throw Exception("Failed to load weather data");
    }
  }
}
