part of 'weather_bloc_bloc.dart';

sealed class WeatherBlocState extends Equatable {
  const WeatherBlocState();

  @override
  List<Object> get props => [];
}

final class WeatherBlocInitial extends WeatherBlocState {}

final class WeatherBlocLoading extends WeatherBlocState {}

final class WeatherBlocSucces extends WeatherBlocState {
  final Weather weather;
  const WeatherBlocSucces({required this.weather});

  @override
  List<Weather> get props => [weather];
}

final class WeatherBlocFailure extends WeatherBlocState {}
