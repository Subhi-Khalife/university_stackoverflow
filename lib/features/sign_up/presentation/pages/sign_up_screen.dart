import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/features/login/presentation/pages/login_screen.dart';

import '../../../../core/widget/app_button.dart';
import '../../../../core/widget/colors.dart';
import '../../../../core/widget/config_screeen.dart';
import '../../../../core/widget/text_field_app.dart';
import '../../../collage_profile/presentation/pages/profile_page.dart';
import '../../../university_with_collage/presentation/bloc/bloc/university_bloc.dart';
import '../../../university_with_collage/presentation/pages/drop_down.dart';
import '../bloc/sign_up/sign_up_bloc.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpScreen();
  }
}

class _SignUpScreen extends State<SignUpScreen> with TickerProviderStateMixin {
  SignUpBloc signUpBloc;
  TextEditingController _firstNameController;
  TextEditingController _secondNameController;
  TextEditingController _emailNameController;
  TextEditingController _passwordNameController;
  TextEditingController _confirmPasswordController;
  TextEditingController _phoneNumberController;
  TextEditingController _collageNumberContoller;
  UniversityBloc universityBloc;
  String universityName;
  String collageName;
  int universityId = 0;
  int collageId = 0;
  bool isFirstSignUpScreen = true;

  @override
  void initState() {
    super.initState();
    signUpBloc = SignUpBloc();
    universityBloc = UniversityBloc();
    universityBloc.add(FetchUiversity());
    _firstNameController = TextEditingController();
    _secondNameController = TextEditingController();
    _emailNameController = TextEditingController();
    _passwordNameController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _collageNumberContoller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    signUpBloc.close();
    universityBloc.close();
    _firstNameController.dispose();
    _secondNameController.dispose();
    _emailNameController.dispose();
    _passwordNameController.dispose();
    _confirmPasswordController.dispose();
    _phoneNumberController.dispose();
    _collageNumberContoller.dispose();
  }

  bool isOpened = false;

  @override
  Widget build(BuildContext context) {
    ConfigScreen configScreen = ConfigScreen(context);
    WidgetSize(configScreen);
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocProvider<SignUpBloc>(
        create: (context) => signUpBloc,
        child: BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context, state) {
            if (state is SuccessSignUp) {
              if (state.user.userTypeId == 5) {
                return Container(
                  color: Colors.green,
                );
              } else {
                return CollageProfilePage();
              }
            } else if (state is ChangeToSecondScreenState) {
              isFirstSignUpScreen = state.state;
            }
            return Center(
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            colors: [
                              colorFirstGrident,
                              colorSecondGrident,
                            ],
                            stops: [0.0, 1],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )),
                      child: Center(
                        child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: (isFirstSignUpScreen)
                                ? firstScreenData()
                                : scondScreenData()),
                      ),
                    ),
                  ),
                ),
              ),
            );
            return Container();
            // return ListView(
            //   padding: EdgeInsets.only(top: 30, left: 12, right: 12),
            //   children: [
            //     Text(
            //       "New Account",
            //       style: boldStyle(
            //           color: colorThemApp, fontSize: Constant.xlargeFont),
            //     ),
            //     SizedBox(height: 10),
            //     Text(
            //       "Welcome to our community in order to sign up, please fill out all filed below",
            //       style: regularStyle(
            //           color: secondColor, fontSize: Constant.mediumFont),
            //     ),
            //     SizedBox(height: 10),
            //     firstNameController(),
            //     SizedBox(height: 10),
            //     secondNameController(),
            //     SizedBox(height: 10),
            //     emailController(),
            //     SizedBox(height: 10),
            //     mobilePhoneController(),
            //     SizedBox(height: 10),
            //     passwordController(),
            //     SizedBox(height: 10),
            //     confirmPasswordController(),
            //     SizedBox(height: 10),
            //     collageNumberController(),
            //     SizedBox(height: 10),
            //     dropDownCollage(),
            //     SizedBox(height: 10),
            //     SizedBox(height: 10),
            //     AppButton(
            //       function: () {
            //         BlocProvider.of<SignUpBloc>(context)
            //           ..add(
            //             SendSignUpRequestEvent(
            //               collageNumber: _collageNumberContoller.text,
            //               email: _emailNameController.text,
            //               lastName: _secondNameController.text,
            //               firstName: _firstNameController.text,
            //               mobile: _phoneNumberController.text,
            //               password: _passwordNameController.text,
            //               collegeId: collageId,
            //               universityId: universityId,
            //             ),
            //           );
            //       },
            //       name: "Sign up",
            //     ),
            //   ],
            // );
          },
        ),
      ),
    );
  }

  Widget scondScreenData() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 10),
        loginAndSignUpButton(),
        SizedBox(height: 10),
        firstNameController(),
        SizedBox(height: 10),
        secondNameController(),
        SizedBox(height: 10),
        emailController(),
        SizedBox(height: 10),
        mobilePhoneController(),
        SizedBox(height: 10),
        passwordController(),
        SizedBox(height: 10),
        confirmPasswordController(),
        SizedBox(height: 10),
        collageNumberController(),
        SizedBox(height: 10),
        AppButton(
            function: () {
              signUpBloc.add(
                SendSignUpRequestEvent(
                  collageNumber: _collageNumberContoller.text,
                  email: _emailNameController.text,
                  lastName: _secondNameController.text,
                  firstName: _firstNameController.text,
                  mobile: _phoneNumberController.text,
                  password: _passwordNameController.text,
                  collegeId: collageId,
                  universityId: universityId,
                ),
              );
            },
            buttonColor: Color(0xff315786),
            elevationValue: 8,
            fontColor: Colors.black,
            name: "Sign up"),
      ],
    );
  }

  Widget firstScreenData() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 10),
        loginAndSignUpButton(),
        SizedBox(height: 28),
        dropDownCollage(),
        SizedBox(height: 20),
        AppButton(
            buttonColor: Color(0xff315786),
            fontColor: Colors.black,
            function: () {
              signUpBloc..add(ChangeToSecondScreen());
            },
            elevationValue: 8,
            name: "Next"),
        SizedBox(height: 28),
      ],
    );
  }

  Widget loginAndSignUpButton() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
              child: Transform.scale(
            scale: 1.1,
            origin: Offset(5, 1),
            child: AppButton(
              function: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) =>
                        false); //  Navigator.pushAndRemoveUntil(context, LoginScreen(), (route) => false);
              },
              name: "Login",
              elevationValue: 10,
              fontColor: colorSecondGrident,
              buttonColor: greyColor,
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
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                          (Route<dynamic> route) => false);
                },
                name: "SignUp",
                fontColor: Colors.black,
                elevationValue: 10,
                buttonColor: Color(0xff315786),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dropDownCollage() {
    return BlocProvider<UniversityBloc>(
      create: (context) => universityBloc,
      child: BlocListener<UniversityBloc, UniversityState>(
        listener: (context, state) {
          universityId = state.universityId;
          collageId = state.collageId;
        },
        child: BlocBuilder<UniversityBloc, UniversityState>(
          builder: (context, state) {
            if (state is UniversityState) {
              return Column(
                children: [
                  DropDown(
                    dropDownListItem: state.univerSityItems,
                    title: state.universityName,
                    isOpened: isOpened,
                    universitySelecetd: true,
                  ),
                  SizedBox(height: 10),
                  AnimatedSize(
                    duration: Duration(milliseconds: 500),
                    vsync: this,
                    child: DropDown(
                      dropDownListItem: state.collegeityItems,
                      title: state.collageName,
                      isOpened: isOpened,
                      universitySelecetd: false,
                    ),
                  ),
                ],
              );
            } else if (state is UniversityIsLoadingState) {
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: colorThemApp,
              ));
            } else if (state is UniversityIsLoadErrorState) {
              return Container(
                color: Colors.red,
                width: 50,
                height: 50,
              );
            } else {
              return Container(
                color: Colors.orange,
                width: 50,
                height: 50,
              );
            }
          },
        ),
      ),
    );
  }

  Widget passwordController() {
    return TextFieldApp(
      controller: _passwordNameController,
      hintText: "your password",
      withIcon: true,
      icon: Icons.email,
      isLookAtPassword: false,
      isTextFieldPassword: false,
      style: TextStyle(color: Colors.black),
      prefixSvg: "lib/svg/mail_icon.svg",
    );
  }

  Widget confirmPasswordController() {
    return TextFieldApp(
      controller: _confirmPasswordController,
      hintText: "confirm your password",
      withIcon: true,
      icon: Icons.email,
      isTextFieldPassword: false,
      style: TextStyle(color: Colors.black),
      prefixSvg: "lib/svg/mail_icon.svg",
    );
  }

  Widget collageNumberController() {
    return TextFieldApp(
      controller: _collageNumberContoller,
      hintText: "Enter collage number",
      withIcon: true,
      icon: Icons.email,
      isTextFieldPassword: false,
      style: TextStyle(color: Colors.black),
      prefixSvg: "lib/svg/mail_icon.svg",
    );
  }

  Widget mobilePhoneController() {
    return TextFieldApp(
      controller: _phoneNumberController,
      hintText: "Enter mobile phone",
      withIcon: true,
      icon: Icons.email,
      isTextFieldPassword: false,
      style: TextStyle(color: Colors.black),
      prefixSvg: "lib/svg/mail_icon.svg",
    );
  }

  Widget emailController() {
    return TextFieldApp(
      controller: _emailNameController,
      hintText: "Enter your email",
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
      hintText: "Enter second name",
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
