import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async {
      bool serviceEnabled;
      LocationPermission permission;
      Position positon;
      emit(WeatherBlocLoading());

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(WeatherBlocFailure());
        return;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(WeatherBlocFailure());
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(WeatherBlocFailure());
        return;
      } else {
        positon = await Geolocator.getCurrentPosition();
      }

      final Weather weather = await event.wf
          .currentWeatherByLocation(positon.latitude, positon.longitude);
      emit(WeatherBlocSucces(weather: weather));
    });
    add(FetchWeather());
  }
}
