part of 'tab_bloc.dart';

abstract class TabEvent extends Equatable {
  const TabEvent();

  @override
  List<Object> get props => [];
}

class FetchTabsEvent extends TabEvent {
//  final int collageNum;

  FetchTabsEvent();
}

class FailedGettingTabsEvent extends TabEvent {}

class SuccessGettingTabsEvent extends TabEvent {}
