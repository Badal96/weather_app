part of 'weather_bloc_bloc.dart';

sealed class WeatherBlocEvent extends Equatable {
  const WeatherBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchWeather extends WeatherBlocEvent {
  final String _apikey = '510add299a361ec63606f50c07e3fde5';
  late final WeatherFactory wf;
  FetchWeather() {
    wf = WeatherFactory(_apikey);
  }
}
