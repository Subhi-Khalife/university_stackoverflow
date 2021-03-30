import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/features/profile/presentation/bloc/bloc/profile_bloc.dart';
import 'package:university/features/sign_up/presentation/bloc/sign_up/sign_up_bloc.dart';

import 'features/common_question/presentation/pages/public_common_question.dart';
import 'features/sign_up/presentation/pages/sign_up_screen.dart';
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
      home: SignUpScreen(),
    );
  }
}