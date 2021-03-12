import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/core/widget/app_button.dart';
import 'package:university/core/widget/colors.dart';
import 'package:university/core/widget/config_screeen.dart';
import 'package:university/core/widget/constant.dart';
import 'package:university/core/widget/font_style.dart';
import 'package:university/core/widget/loading_dialog.dart';
import 'package:university/core/widget/text_field_app.dart';
import 'package:university/features/login/presentation/bloc/login/login_bloc.dart';

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
  Widget build(BuildContext context) {
    ConfigScreen configScreen = ConfigScreen(context);
    WidgetSize widgetSize = WidgetSize(configScreen);
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(top: 30, left: 12, right: 12),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              showSignInText(),
              SizedBox(height: 20),
              showDescription(),
              SizedBox(height: 20),
              emailTextField(),
              SizedBox(height: 20),
              passwordTextField(),
              SizedBox(height: 20),
              loginButton()
            ],
          )
        ],
      ),
    );
  }

  Widget loginButton() {
    return BlocProvider(
      create: (context) => loginBloc,
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginSuccess) {
            print("Done");
            return Container();
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
