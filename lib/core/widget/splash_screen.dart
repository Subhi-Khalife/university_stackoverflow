import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/core/constant_info.dart';
import 'package:university/core/widget/main_screen_dialog.dart';
import 'package:university/features/login/data/models/login_model.dart';
import 'package:university/features/post/presentation/pages/show_all_posts.dart';

import 'main_screen_dialog.dart';

class SplashScreen extends StatefulWidget {
  @override
  VideoState createState() => VideoState();
}

class VideoState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  AnimationController animationController;
  Animation<double> animation;
  SharedPreferences sharedPreferences;
  startTime() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    WidgetsFlutterBinding.ensureInitialized();
    ConstantInfo constantInfo = ConstantInfo.getInstance();

    if (sharedPreferences.getString("user") != null) {
      String user = sharedPreferences.getString("user");
      constantInfo.setUserInfoValue(loginModelFromJson(user).user);
    }
    if (sharedPreferences.getBool("loginSuccess")==true) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => ShowAllPosts()));
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => MainScreenDialog()));
    }
  }

  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 1));
    animation =
        new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // new Column(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   mainAxisSize: MainAxisSize.min,
          //   children: <Widget>[
          //     // Padding(
          //     //     padding: EdgeInsets.only(bottom: 30.0),
          //     //     child: new Image.asset(
          //     //       'assets/powered_by.png',
          //     //       height: 25.0,
          //     //       fit: BoxFit.scaleDown,
          //     //     ))
          //   ],
          // ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image.asset(
                'assets/devs.jpg',
                width: animation.value * 250,
                height: animation.value * 250,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
