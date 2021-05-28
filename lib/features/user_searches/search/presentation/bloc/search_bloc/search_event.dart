part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class FetchingSearchInfoEvent extends SearchEvent {}

class FailedGettingSearchInfoEvent extends SearchEvent {}

class SuccessGettingSearchInfoEvent extends SearchEvent {}
