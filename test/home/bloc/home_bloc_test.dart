import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';
import 'package:wheater_app/models/models.dart';
import 'package:wheater_app/pages/home/bloc/home_bloc.dart';
import 'package:wheater_app/repositories/location_repo.dart';
import 'package:wheater_app/repositories/weather_repo.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

class MockLocationRespository extends Mock implements LocationRepository {}

main() {
  group('HomeBloc', () {
    MockWeatherRepository weatherRepo;
    MockLocationRespository locationRepo;
    HomeBloc homeBloc;

    setUp(() {
      weatherRepo = MockWeatherRepository();
      locationRepo = MockLocationRespository();
      homeBloc = HomeBloc(weatherRepo: weatherRepo, locationRepo: locationRepo);
    });

    tearDown(() {
      homeBloc?.close();
    });

    test('check initial state', () {
      expect(homeBloc.initialState, HomeInitial());
    });

    group('get weather', () {
      test('from position', () {
        final WeatherData data = WeatherData.fromJson({
          "coord": {"lon": -122.41, "lat": 37.79},
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10d"
            }
          ],
          "main": {
            "temp": 286.89,
            "feels_like": 282.89,
            "temp_min": 284.26,
            "temp_max": 289.82,
            "pressure": 1027,
            "humidity": 77,
            "sea_level": null,
            "grnd_level": null
          },
          "dt": 1580242996,
          "sys": {"country": "US", "sunrise": 1580224626, "sunset": 1580261264},
          "name": "San Francisco",
          "cod": 200,
          "lastUpdate": "29-01-2020 03:23:16"
        });
        when(locationRepo.getCurrentLocation()).thenAnswer(
            (_) => Future.value(Position(latitude: 37.79, longitude: -122.41)));
        when(weatherRepo.getWeatherFromPosition(
                lat: 37.79, long: -122.41, isRefresh: false))
            .thenAnswer((_) => Future.value(data));
        expectLater(
          homeBloc,
          emitsInOrder([
            HomeInitial(),
            HomeLoading(),
            HomeLocationReady(data: data),
          ]),
        );
        homeBloc.add(GetPositionEvent(isRefresh: false));
      });

      test('from position', () {
        when(locationRepo.getCurrentLocation()).thenThrow('Location Error');
        expectLater(
          homeBloc,
          emitsInOrder([
            HomeInitial(),
            HomeLoading(),
            HomeError(errorMessage: 'Location Error'),
          ]),
        );
        homeBloc.add(GetPositionEvent(isRefresh: false));
      });
    });

    group('get weather 2', () {
      test('from city', () {
        final WeatherData data = WeatherData.fromJson({
          "coord": {"lon": -122.41, "lat": 37.79},
          "weather": [
            {
              "id": 500,
              "main": "Rain",
              "description": "light rain",
              "icon": "10d"
            }
          ],
          "main": {
            "temp": 286.89,
            "feels_like": 282.89,
            "temp_min": 284.26,
            "temp_max": 289.82,
            "pressure": 1027,
            "humidity": 77,
            "sea_level": null,
            "grnd_level": null
          },
          "dt": 1580242996,
          "sys": {"country": "US", "sunrise": 1580224626, "sunset": 1580261264},
          "name": "San Francisco",
          "cod": 200,
          "lastUpdate": "29-01-2020 03:23:16"
        });
        when(weatherRepo.getWeatherFromCity(city: 'San Fransisco'))
            .thenAnswer((_) => Future.value(data));
        expectLater(
          homeBloc,
          emitsInOrder([
            HomeInitial(),
            HomeLoading(),
            HomeSearch(data: data)
          ]),
        );
        homeBloc.add(SearchEvent(searchText: 'San Fransisco'));
      });

      test('from city Error', () {
        when(weatherRepo.getWeatherFromCity(city: 'San Fransisco'))
            .thenThrow('Search Error');
        expectLater(
          homeBloc,
          emitsInOrder([
            HomeInitial(),
            HomeLoading(),
            HomeError(errorMessage: 'Search Error'),
          ]),
        );
        homeBloc.add(SearchEvent(searchText: 'San Fransisco'));
      });
    });
  });
}
