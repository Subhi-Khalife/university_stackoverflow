import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/features/splash_screen/presentation/pages/splash_screen.dart';
import 'features/profile/presentation/bloc/bloc/profile_bloc.dart';
import 'features/university_with_collage/presentation/bloc/bloc/university_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<UniversityBloc>(
          create: (context) {
            return UniversityBloc()..add(FetchUiversity());
          },
        ),
        BlocProvider<ProfileBloc>(
          create: (context) {
            return ProfileBloc()..add(FetchProfile());
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
      theme: ThemeData(
          scaffoldBackgroundColor: Color(0xff171F24),
          primaryColor: Color(0xFF034EA3),
          hintColor:  Colors.white70,
          accentColor: Colors.white,
          cardColor: Colors.white,
          
          ),
      title: 'Flutter Demo',
      home: SplashScreen(),
    );
  }
}
