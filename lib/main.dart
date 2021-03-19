import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/sign_up/presentation/pages/sign_up_screen.dart';
import 'features/university_with_collage/presentation/bloc/bloc/university_bloc.dart';

void main() {
  runApp(
    BlocProvider<UniversityBloc>(
      create: (context) {
        return UniversityBloc()..add(FetchUiversity());
      },
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
