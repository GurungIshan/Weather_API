import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages/weather_page.dart';
import 'bloc/weather_bloc.dart';
import 'repositories/weather_repository.dart';

void main() {
  final WeatherRepository repository = WeatherRepository();

  runApp(
    BlocProvider(
      create: (_) => WeatherBloc(repository),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherPage(),
    );
  }
}
