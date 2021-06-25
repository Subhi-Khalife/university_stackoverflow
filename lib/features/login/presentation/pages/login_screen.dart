import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/core/validation.dart';
import 'package:university/core/widget/container_app_decoration.dart';
import 'package:university/core/widget/show_message.dart';
import 'package:university/features/splash_screen/presentation/pages/splash_screen.dart';
import 'package:university/features/sign_up/presentation/pages/sign_up_screen.dart';
import '../../../../core/widget/app_button.dart';
import '../../../../core/widget/colors.dart';
import '../../../../core/widget/config_screeen.dart';
import '../../../../core/widget/constant.dart';
import '../../../../core/widget/font_style.dart';
import '../../../../core/widget/text_field_app.dart';
import '../../../sign_up/presentation/pages/sign_up_screen.dart';
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
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.7,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              decoration: containerDecoration(),
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
                        false); 
              },
              name: "Sign up",
              elevationValue: 10,
              fontColor: Theme.of(context).primaryColor,
              buttonColor: Theme.of(context).accentColor,
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
              fontColor: Theme.of(context).accentColor,
              elevationValue: 10,
              buttonColor: Theme.of(context).primaryColor,
            ),
          )),
        ],
      ),
    );
  }

  Widget loginButton() {
    return BlocProvider<LoginBloc>(
      create: (context) => loginBloc,
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SplashScreen()));
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            print("the current state is ");
            if (state is LoginSuccess) {
              return Container();
              // if (state.user.userTypeId == 5) {
              //   return ProfilePage();
              // } else {
              //   return CollageProfilePage();
              // }
            } else if (state is LoadingState) {
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: colorThemApp,
              ));
            } else {
              return AppButton(
                buttonColor: Theme.of(context).primaryColor,
                fontColor: Theme.of(context).accentColor,
                elevationValue: 8,
                function: () {
                  if (_emailController.text.trim().length == 0) {
                    showMessage("Please add  your email");
                  } else if (_emailController.text.trim().length != 0) {
                    RegExp regex = RegExp(Validation.EMAILPATTERN);
                    if (!regex.hasMatch(_emailController.text)) {
                      showMessage("your email is not  email type");
                    } else {
                      if (_passwordController.text.trim().length < 6) {
                        showMessage("password should greater or equal 8 ");
                      } else {
                        BlocProvider.of<LoginBloc>(context)
                          ..add(
                            SendLoginRequest(
                                email: _emailController.text,
                                password: _passwordController.text),
                          );
                      }
                    }
                  }
                },
                name: "Login",
              );
            }
          },
        ),
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
        colorText: Colors.white,
        colorFill: Colors.white);
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
      textInputType: TextInputType.emailAddress,
    );
  }

  Widget showSignInText() {
    return Text(
      "Login",
      style: boldStyle(color: colorThemApp, fontSize: Constant.xlargeFont + 6),
    );
  }
}
