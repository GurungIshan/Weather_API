import '../model/weather_model.dart';
import '../services/weather_service.dart';

class WeatherRepository {
  final WeatherService _service = WeatherService();

  Future<WeatherModel> getWeather(String city) async {
    final json = await _service.fetchWeatherJson(city);
    return WeatherModel.fromJson(json);
  }
}
// Calls API via service
// Gets raw JSON
// Converts JSON -> WeatherModel
// Returns WeatherModel


// calls service
// converts JSON to Model
// returns WeatherModel
