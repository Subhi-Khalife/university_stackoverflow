import 'package:flutter/material.dart';
import 'package:university/core/widget/config_screeen.dart';
import 'package:university/features/login/presentation/pages/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      title: 'Flutter Demo',
      home: LoginScreen(),
    );
  }
}