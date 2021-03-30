import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/features/collage_profile/presentation/bloc/collage_profile_bloc/collage_profile_bloc.dart';
import 'package:university/features/collage_profile/presentation/pages/profile_page.dart';
import 'features/sign_up/presentation/pages/sign_up_screen.dart';

void main() {
  runApp(
    BlocProvider<CollageProfileBloc>(
      create: (context) =>
      CollageProfileBloc()
        ..add(
          FetchCollageProfile(collageNum: 6),
        ),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        body: Center(
          child: FlatButton(
            child: Text("Test"),
            onPressed: () {
              BlocProvider.of<CollageProfileBloc>(context)
                ..add(
                  FetchCollageProfile(collageNum: 6),
                );
              return CollageProfilePage();
//                Navigator.pushReplacement(
//                  context,
//                  MaterialPageRoute(
//                    builder: (context) {
//
//                    },
//                  ),
//                );
            },
          ),
        ),
      ),
    );
  }
}
