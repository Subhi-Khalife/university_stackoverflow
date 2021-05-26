import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/features/feedback/presentation/pages/feedback_screen.dart';
import 'package:university/features/tabs/presentation/pages/tabs_screen.dart';
import 'features/profile/presentation/bloc/bloc/profile_bloc.dart';
import 'features/rate/presentation/screen/rate_screen.dart';
import 'features/university_with_collage/presentation/bloc/bloc/university_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<UniversityBloc>(
          create: (context) {
            return UniversityBloc()
              ..add(FetchUiversity());
          },
        ),
        BlocProvider<ProfileBloc>(
          create: (context) {
            return ProfileBloc()
              ..add(FetchProfile());
          },
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: RateScreen(),
    );
  }
}
