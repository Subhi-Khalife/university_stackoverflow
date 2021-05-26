part of 'tab_bloc.dart';

abstract class TabState extends Equatable {
  const TabState();

  @override
  List<Object> get props => [];
}

class TabInitial extends TabState {}

class SuccessGettingTabsState extends TabState {
  final TabModel tabModel;

  SuccessGettingTabsState(this.tabModel);
}

class FailedGettingTabsState extends TabState {}

class LoadingGettingTabsState extends TabState {}
