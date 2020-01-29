import 'package:flutter/material.dart';
import 'package:wheater_app/models/models.dart';
import 'package:wheater_app/shared/shared.dart';
import 'package:intl/intl.dart';

class WeatherRepository {
  Future<WeatherData> getWeatherFromCity(
      {@required String city}) async {
    try {
      final Map<String, dynamic> _requestParam = {
        'q': '$city',
      };
      Map<String, dynamic> response =
          await network.getHttp(CanonicalPath.weatherPath, _requestParam);
      return WeatherData.fromJson(response);
    } on Exception catch (e) {
      print(e);
      throw e;
    }
  }

  Future<WeatherData> getWeatherFromPosition(
      {double lat, double long, bool isRefresh}) async {
    try {
      final Map<String, dynamic> _requestParam = {
        'lat': lat,
        'lon': long,
      };
      Map<String, dynamic> response =
          await storage.getData(boxName: 'Weather', key: 'weather');
      if (isRefresh || response == null) {
        response =
            await network.getHttp(CanonicalPath.weatherPath, _requestParam);
        final f = DateFormat('dd-MM-yyyy hh:mm:ss');
        final now = f.format(DateTime.now());
        response.addAll({'lastUpdate': '$now'});
        await storage.putData(
            boxName: 'Weather', key: 'weather', data: response);
      }
      return WeatherData.fromJson(response);
    } on Exception catch (e) {
      throw e;
    }
  }
}
