part of 'tabs_bloc.dart';

abstract class TabsState  {
  const TabsState();
}

class TabsInitial extends TabsState {}

class LoadingState extends TabsState {}

class FailedGetAllTabs extends TabsState {}

class SuccessGetAllTabs extends TabsState {
  final List<Taps> taps;
  SuccessGetAllTabs({this.taps});
}
