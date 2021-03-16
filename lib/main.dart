import 'package:flutter/material.dart';
import 'features/sign_up/presentation/pages/sign_up_screen.dart';

void main() {
  runApp(MyApp());
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
