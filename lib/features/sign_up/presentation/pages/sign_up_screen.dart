import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/core/widget/colors.dart';
import 'package:university/core/widget/config_screeen.dart';
import 'package:university/core/widget/constant.dart';
import 'package:university/core/widget/font_style.dart';
import 'package:university/core/widget/text_field_app.dart';
import 'package:university/features/sign_up/presentation/bloc/sign_up/sign_up_bloc.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpScreen();
  }
}

class _SignUpScreen extends State<SignUpScreen> {
  TextEditingController _firstNameController;
  TextEditingController _secondNameController;
  TextEditingController _emailNameController;
  TextEditingController _passWordNameController;
  TextEditingController _confirmPassWordController;
  TextEditingController _phoneNumberController;
  TextEditingController _collageNumberContoller;

  SignUpBloc signUpBloc;
  @override
  void initState() {
    super.initState();
    signUpBloc = SignUpBloc();
    _firstNameController = TextEditingController();
    _secondNameController = TextEditingController();
    _emailNameController = TextEditingController();
    _passWordNameController = TextEditingController();
    _confirmPassWordController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _collageNumberContoller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    signUpBloc.close();
    _firstNameController.dispose();
    _secondNameController.dispose();
    _emailNameController.dispose();
    _passWordNameController.dispose();
    _confirmPassWordController.dispose();
    _phoneNumberController.dispose();
    _collageNumberContoller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ConfigScreen configScreen = ConfigScreen(context);
    WidgetSize widgetSize = WidgetSize(configScreen);
    return Scaffold(
      body: BlocProvider(
        create: (context) => signUpBloc,
        child: BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context, state) {
            return ListView(
              padding: EdgeInsets.only(top: 30, left: 12, right: 12),
              children: [
                Text(
                  "New Account",
                  style: boldStyle(
                      color: colorThemApp, fontSize: Constant.xlargeFont),
                ),
                SizedBox(height: 10),
                Text(
                  "Welcome to our community in order to sign up, please fill out all filed below",
                  style: regularStyle(
                      color: secondColor, fontSize: Constant.mediumFont),
                ),
                SizedBox(height: 10),
                firstNameController(),
                SizedBox(height: 10),
                secondNameController(),
                SizedBox(height: 10),
                emailController(),
                SizedBox(height: 10),
                mobilePhoneController(),
                SizedBox(height: 10),
                collageNumberController(),
                SizedBox(height: 10),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget collageNumberController() {
    return TextFieldApp(
      controller: _secondNameController,
      hintText: "Enter first name",
      withIcon: true,
      icon: Icons.email,
      isTextFieldPassword: false,
      style: TextStyle(color: Colors.black),
      prefixSvg: "lib/svg/mail_icon.svg",
    );
  }

  Widget mobilePhoneController() {
    return TextFieldApp(
      controller: _secondNameController,
      hintText: "Enter first name",
      withIcon: true,
      icon: Icons.email,
      isTextFieldPassword: false,
      style: TextStyle(color: Colors.black),
      prefixSvg: "lib/svg/mail_icon.svg",
    );
  }

  Widget emailController() {
    return TextFieldApp(
      controller: _secondNameController,
      hintText: "Enter first name",
      withIcon: true,
      icon: Icons.email,
      isTextFieldPassword: false,
      style: TextStyle(color: Colors.black),
      prefixSvg: "lib/svg/mail_icon.svg",
    );
  }

  Widget secondNameController() {
    return TextFieldApp(
      controller: _secondNameController,
      hintText: "Enter first name",
      withIcon: true,
      icon: Icons.email,
      isTextFieldPassword: false,
      style: TextStyle(color: Colors.black),
      prefixSvg: "lib/svg/mail_icon.svg",
    );
  }

  Widget firstNameController() {
    return TextFieldApp(
      controller: _firstNameController,
      hintText: "Enter first name",
      withIcon: true,
      icon: Icons.email,
      isTextFieldPassword: false,
      style: TextStyle(color: Colors.black),
      prefixSvg: "lib/svg/mail_icon.svg",
    );
  }
}
