import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wheater_app/models/models.dart';
import 'package:wheater_app/repositories/location_repo.dart';
import 'package:wheater_app/repositories/weather_repo.dart';
import 'package:wheater_app/shared/shared.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({@required this.weatherRepo, @required this.locationRepo})
      : assert(weatherRepo != null, locationRepo != null);

  final WeatherRepository weatherRepo;
  final LocationRepository locationRepo;

  @override
  HomeState get initialState => HomeInitial();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is GetPositionEvent) {
      yield* mapGetPositionEventToState(event.isRefresh);
    }
    if (event is SearchEvent) {
      yield* mapSearchEventToState(event.searchText);
    }
  }

  Stream<HomeState> mapGetPositionEventToState(bool isRefresh) async* {
    try {
      yield HomeLoading();
      Position pos = await locationRepo.getCurrentLocation();
      WeatherData res = await weatherRepo.getWeatherFromPosition(
          lat: pos.latitude, long: pos.longitude, isRefresh: isRefresh);
      yield HomeLocationReady(data: res);
    } catch (e) {
      yield HomeError(errorMessage: e.toString());
    }
  }

  Stream<HomeState> mapSearchEventToState(String searchText) async* {
    try {
      yield HomeLoading();
      WeatherData res =
          await weatherRepo.getWeatherFromCity(city: searchText);
    
      yield HomeSearch(data: res);
    } on Exception catch (e) {
      yield HomeError(errorMessage: e.toString());
    }
  }
}
