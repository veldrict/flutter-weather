part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLocationReady extends HomeState {
  const HomeLocationReady({@required this.data});
  final WeatherData data;
  @override
  List<Object> get props => [data];

  // @override
  // String toString() {
  //   return 'HomeLocation Ready { data:${data.toRawJson()} }';
  // }
}

class HomeSearch extends HomeState {
  const HomeSearch({@required this.data});
  final WeatherData data;

  @override
  List<Object> get props => [data];
}

class HomeError extends HomeState {
  const HomeError({@required this.errorMessage});
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() => 'HomeError { errorMessage : $errorMessage }';
}
