import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wheater_app/pages/home/bloc/home_bloc.dart';
import 'package:wheater_app/pages/home/home_page.dart';
import 'package:wheater_app/repositories/location_repo.dart';
import 'package:wheater_app/repositories/weather_repo.dart';

class Routers {
  static final String home = '/';
  static final String search = '/search';

  final route = <String, WidgetBuilder>{
    Routers.home: (BuildContext context) {
      return BlocProvider<HomeBloc>(
        create: (BuildContext context) => HomeBloc(
            weatherRepo: WeatherRepository(),
            locationRepo: LocationRepository(
                geolocator: Geolocator()..forceAndroidLocationManager))
          ..add(GetPositionEvent(isRefresh: false)),
        child: HomePage(),
      );
    }
  };
}
