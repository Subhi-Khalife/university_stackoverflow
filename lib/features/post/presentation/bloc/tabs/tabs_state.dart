part of 'tabs_bloc.dart';

abstract class TabsState extends Equatable {
  const TabsState();

  @override
  List<Object> get props => [];
}

class TabsInitial extends TabsState {}

class LoadingState extends TabsState {}

class FailedGetAllTabs extends TabsState {}

class SuccessGetAllTabs extends TabsState {
  final List<Taps> taps;
  SuccessGetAllTabs({this.taps});
}
