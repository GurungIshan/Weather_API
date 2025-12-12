import '../model/weather_model.dart';
import '../services/weather_service.dart';

class WeatherRepository {
  final WeatherService _service = WeatherService();

  Future<WeatherModel> getWeather(String city) async {
    final json = await _service.getWeatherJson(city);

    return WeatherModel.fromJson(json);
  }
}
// UI calls repository not the service
// Repository is responsible for converting JSON to model