import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = "970a152b7436320503e35de99d102fab";

  Future<Map<String, dynamic>> fetchWeatherJson(String city) async {
    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("City not found");
    }
  }
}

// only talk to internet and return JSON
