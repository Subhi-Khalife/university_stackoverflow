import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class LoadingView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(
          backgroundColor:  colorThemApp,
          strokeWidth: 1.8,
          valueColor: AlwaysStoppedAnimation<Color> (Colors.white70),
        ),
      ),
    );
  }

}