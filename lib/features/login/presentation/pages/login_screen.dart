import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/features/sign_up/presentation/pages/sign_up_screen.dart';

import '../../../../core/widget/app_button.dart';
import '../../../../core/widget/colors.dart';
import '../../../../core/widget/config_screeen.dart';
import '../../../../core/widget/constant.dart';
import '../../../../core/widget/font_style.dart';
import '../../../../core/widget/text_field_app.dart';
import '../../../collage_profile/presentation/pages/profile_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../bloc/login/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  TextEditingController _emailController;
  TextEditingController _passwordController;
  LoginBloc loginBloc;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    loginBloc = LoginBloc();
  }

  @override
  void dispose() {
    super.dispose();
    loginBloc.close();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ConfigScreen configScreen = ConfigScreen(context);
    WidgetSize widgetSize = WidgetSize(configScreen);
    return Scaffold(
      backgroundColor: backGroupColor,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.7,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    loginAndSignUpButton(),
                    SizedBox(height: 28),
                    emailTextField(),
                    SizedBox(height: 10),
                    passwordTextField(),
                    SizedBox(height: 28),
                    loginButton()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    //    ListView(
    //     padding: EdgeInsets.only(top: 30, left: 12, right: 12),
    //     children: [
    //       Column(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           showSignInText(),
    //           SizedBox(height: 20),
    //           showDescription(),
    //           SizedBox(height: 20),
    //           emailTextField(),
    //           SizedBox(height: 20),
    //           passwordTextField(),
    //           SizedBox(height: 20),
    //           loginButton()
    //         ],
    //       )
    //     ],
    //   ),
    // );
  }

  Widget loginAndSignUpButton() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.rtl,
        children: [
          Flexible(
              child: Transform.scale(
            scale: 1.1,
            origin: Offset(5, 1),
            child: AppButton(
              function: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                    (Route<dynamic> route) =>
                        false); //  Navigator.pushAndRemoveUntil(context, LoginScreen(), (route) => false);
              },
              name: "Sign up",
              elevationValue: 10,
              fontColor: Colors.black,
              buttonColor: Colors.white,
            ),
          )),
          Flexible(
              child: Transform.scale(
            scale: 1.1,
            origin: Offset(5, 1),
            child: AppButton(
              function: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) => false);
              },
              name: "Login",
              elevationValue: 10,
            ),
          )),
        ],
      ),
    );
  }

  Widget loginButton() {
    return BlocProvider<LoginBloc>(
      create: (context) => loginBloc,
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          print("the current state is $state");
          if (state is LoginSuccess) {
            print("Done");
            if (state.user.userTypeId == 5) {
              return ProfilePage();
            } else {
              return CollageProfilePage();
            }
          } else if (state is LoadingState) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: colorThemApp,
            ));
          } else {
            return AppButton(
              function: () {
                BlocProvider.of<LoginBloc>(context)
                  ..add(
                    SendLoginRequest(
                        email: _emailController.text,
                        password: _passwordController.text),
                  );
              },
              name: "Login",
            );
          }
        },
      ),
    );
  }

  Widget showDescription() {
    return Text(
      "Welcome again to our community , please choose a login type .",
      style: regularStyle(
        color: secondColor,
        fontSize: Constant.mediumFont,
      ),
    );
  }

  Widget passwordTextField() {
    return TextFieldApp(
      controller: _passwordController,
      hintText: "Enter your password",
      withIcon: true,
      icon: Icons.email,
      isTextFieldPassword: false,
      style: TextStyle(color: Colors.black),
      prefixSvg: "lib/svg/mail_icon.svg",
    );
  }

  Widget emailTextField() {
    return TextFieldApp(
      controller: _emailController,
      hintText: "Enter your email",
      withIcon: true,
      icon: Icons.email,
      isTextFieldPassword: false,
      style: TextStyle(color: Colors.black),
      prefixSvg: "lib/svg/mail_icon.svg",
    );
  }

  Widget showSignInText() {
    return Text(
      "Login",
      style: boldStyle(color: colorThemApp, fontSize: Constant.xlargeFont + 6),
    );
  }
}
