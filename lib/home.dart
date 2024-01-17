import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/bloc/weather_bloc_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    WeatherBlocBloc weatherblock = WeatherBlocBloc();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              weatherblock.add(FetchWeather());
            },
            icon: const Icon(
              Icons.refresh,
              size: 30,
            ),
            color: Colors.white,
          ),
          const SizedBox(
            width: 20,
          )
        ],
        backgroundColor: Colors.transparent,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      backgroundColor: Colors.black,
      body: BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
          bloc: weatherblock,
          builder: (context, state) {
            if (state is WeatherBlocLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is WeatherBlocFailure) {
              return const Center(child: Text('failure'));
            }
            if (state is WeatherBlocSucces) {
              return Padding(
                padding:
                    const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
                child: SizedBox(
                  height: h,
                  child: Stack(
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(10, -0.3),
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.deepPurple,
                          ),
                          height: 300,
                          width: 300,
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(-10, -0.3),
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.deepPurple,
                          ),
                          height: 300,
                          width: 300,
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(0, -1.2),
                        child: Container(
                          color: const Color(0xffffab40),
                          height: 300,
                          width: 600,
                        ),
                      ),
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                        child: Container(
                          color: Colors.transparent,
                        ),
                      ),
                      SizedBox(
                        height: h,
                        width: w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '📍 ${state.weather.areaName.toString()}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              'Good Morning',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                            weatherConditionPicture(
                                state.weather.weatherConditionCode!),
                            Center(
                              child: Text(
                                '${state.weather.temperature!.celsius!.toStringAsFixed(0)}℃',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 55,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Center(
                              child: Text(
                                state.weather.weatherDescription
                                    .toString()
                                    .toUpperCase(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: Text(
                                DateFormat('MMMMEEEEd')
                                    .format(state.weather.date!),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'lib/assets/11.png',
                                      scale: 8,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Sunrise',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          DateFormat.jmv()
                                              .format(state.weather.sunrise!),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'lib/assets/12.png',
                                      scale: 8,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Sunset',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          DateFormat.jmv()
                                              .format(state.weather.sunset!),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Divider(
                                color: Colors.grey,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'lib/assets/13.png',
                                      scale: 8,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Temp max',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          '${state.weather.tempMax!.celsius!.toStringAsFixed(0)}℃',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'lib/assets/14.png',
                                      scale: 8,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Temp min',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          '${state.weather.tempMin!.celsius!.toStringAsFixed(0)}℃',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            return const Center(
                child: Text('turn on your location and try again'));
          }),
    );
  }
}

Widget weatherConditionPicture(int weathercode) {
  int weatherAsset = 7;
  switch (weathercode) {
    case (> 200 && < 210):
      weatherAsset = 1;
      break;
    case (>= 300 && < 310):
      weatherAsset = 2;
      break;
    case (>= 500 && < 510):
      weatherAsset = 3;
      break;
    case (>= 600 && < 610):
      weatherAsset = 4;
      break;
    case (>= 700 && < 710):
      weatherAsset = 5;
      break;
    case (800):
      weatherAsset = 7;
      break;

    case (> 800 && < 810):
      weatherAsset = 8;
      break;
  }
  return Image.asset(
    'lib/assets/$weatherAsset.png',
  );
}
