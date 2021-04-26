import 'package:flutter/material.dart';
import 'package:university/features/common_question/presentation/pages/public_common_question.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: PublicCommonQuestion(),
    );
  }
}
