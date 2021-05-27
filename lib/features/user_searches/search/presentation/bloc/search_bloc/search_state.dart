part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SuccessGettingSearchInfoState extends SearchState {
  final SearchModel searchModel;

  SuccessGettingSearchInfoState(
    this.searchModel,
  );
}

class FailedGettingSearchInfoState extends SearchState {}

class LoadingSearchInfoState extends SearchState {}
