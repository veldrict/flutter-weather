part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetPositionEvent extends HomeEvent {
  const GetPositionEvent({@required this.isRefresh});
  final bool isRefresh;
  @override
  List<Object> get props => [isRefresh];
}

class SearchEvent extends HomeEvent {
  const SearchEvent({@required this.searchText});
  final String searchText;

  @override
  List<Object> get props => [searchText];
}
