import 'dart:async';
import 'package:flutter/material.dart';
import 'package:university/core/widget/config_screeen.dart';
import 'package:university/features/splash_screen/domain/init_value.dart';
import 'package:university/features/splash_screen/domain/navigation_handler.dart';

class SplashScreen extends StatefulWidget {
  @override
  VideoState createState() => VideoState();
}

class VideoState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;
  AnimationController animationController;
  Animation<double> animation;
  startTime() async {
    await InitValue().autoInitialValues();
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, NavigationHandler().navigationPage(context));
  }

  // void navigationPage() {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   ConstantInfo constantInfo = ConstantInfo.getInstance();

  //   if (sharedPreferences.getString("user") != null) {
  //     String user = sharedPreferences.getString("user");
  //     constantInfo.setUserInfoValue(loginModelFromJson(user).user);
  //   }
  //   if (sharedPreferences.getBool("loginSuccess")==true) {
  //     Navigator.of(context)
  //         .push(MaterialPageRoute(builder: (context) => ShowAllPosts()));
  //   } else {
  //     Navigator.of(context)
  //         .push(MaterialPageRoute(builder: (context) => MainScreenDialog()));
  //   }
  // }

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
    ConfigScreen configScreen = ConfigScreen(context);
    WidgetSize(configScreen);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
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
