import '../model/weather_model.dart';

class WeatherState {
  final bool isLoading;
  final WeatherModel? data;
  final String? error;

  WeatherState({
    this.isLoading = false,
    this.data,
    this.error,
  });

  factory WeatherState.loading() => WeatherState(isLoading: true);

  factory WeatherState.success(WeatherModel model) =>
      WeatherState(data: model);

  factory WeatherState.error(String message) =>
      WeatherState(error: message);
}
