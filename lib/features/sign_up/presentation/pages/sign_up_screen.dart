import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/core/validation.dart';
import 'package:university/core/widget/loading_view.dart';
import 'package:university/core/widget/show_message.dart';
import 'package:university/features/splash_screen/presentation/pages/splash_screen.dart';

import '../../../../core/widget/app_button.dart';
import '../../../../core/widget/colors.dart';
import '../../../../core/widget/config_screeen.dart';
import '../../../../core/widget/text_field_app.dart';
import '../../../collage_profile/presentation/pages/profile_page.dart';
import '../../../login/presentation/pages/login_screen.dart';
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
  ValueNotifier<bool> isLookingPassword = ValueNotifier(false);
  ValueNotifier<bool> isLookingVerifiyPassword = ValueNotifier(false);

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
      body: BlocProvider<SignUpBloc>(
        create: (context) => signUpBloc,
        child: BlocListener<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SuccessSignUp) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SplashScreen()));
            }
          },
          child: BlocBuilder<SignUpBloc, SignUpState>(
            builder: (context, state) {
              if (state is ChangeToSecondScreenState) {
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
                              child: (isFirstSignUpScreen) ? firstScreenData() : scondScreenData()),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
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
        BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context, state) {
            if (state is LoadingState) return LoadingView();
            return AppButton(
                function: () {
                  if (_firstNameController.text.trim().length == 0)
                    showMessage("Please enter your first name");
                  else if (_secondNameController.text.trim().length == 0)
                    showMessage("Please enter your second name");
                  else if (_emailNameController.text.trim().length == 0)
                    showMessage("Please enter your email");
                  else {
                    RegExp regex = RegExp(Validation.EMAILPATTERN);
                    if (!regex.hasMatch(_emailNameController.text)) {
                      showMessage("your email is not  email type");
                    } else {
                      if (_phoneNumberController.text.trim().length == 0)
                        showMessage("Please enter your phone number");
                      else if (_passwordNameController.text.trim().length < 6)
                        showMessage("Please enter your Password at least 8 char");
                      else if (_confirmPasswordController.text.trim().length < 6)
                        showMessage("Please enter your confirm password at least 8 char");
                      else if (_passwordNameController.text != _confirmPasswordController.text)
                        showMessage("confirm password and password not same");
                      else if (_collageNumberContoller.text.trim().length == 0)
                        showMessage("Please add confirm number");
                      else
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
                    }
                  }
                },
                buttonColor: Theme.of(context).primaryColor,
                elevationValue: 8,
                fontColor: Theme.of(context).accentColor,
                name: "Sign up");
          },
        ),
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
            buttonColor: Theme.of(context).primaryColor,
            fontColor: Theme.of(context).accentColor,
            function: () {
              if (universityId == -1)
                showMessage("Please select you university first");
              else if (collageId == -1)
                showMessage("Please select you collage first");
              else
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
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                      (Route<dynamic> route) => false);
                },
                name: "SignUp",
                fontColor: Theme.of(context).accentColor,
                elevationValue: 10,
                buttonColor: Theme.of(context).primaryColor,
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
          },
        ),
      ),
    );
  }

  Widget passwordController() {
    return ValueListenableBuilder<bool>(
        valueListenable: isLookingPassword,
        builder: (context, value, _) {
          return TextFieldApp(
            controller: _passwordNameController,
            hintText: "your password",
            withIcon: true,
            icon: Icons.email,
            isLookAtPassword: value,
            onPressedLookAtPassword: () {
              isLookingPassword.value = !isLookingPassword.value;
            },
            isTextFieldPassword: true,
            style: TextStyle(color: Colors.black),
            prefixSvg: "lib/svg/mail_icon.svg",
          );
        });
  }

  Widget confirmPasswordController() {
    return ValueListenableBuilder<bool>(
        valueListenable: isLookingVerifiyPassword,
        builder: (context, value, _) {
          return TextFieldApp(
            controller: _confirmPasswordController,
            hintText: "confirm your password",
            withIcon: true,
            icon: Icons.email,
            isLookAtPassword: value,
            onPressedLookAtPassword: () {
              isLookingVerifiyPassword.value = !isLookingVerifiyPassword.value;
            },
            isTextFieldPassword: true,
            style: TextStyle(color: Colors.black),
            prefixSvg: "lib/svg/mail_icon.svg",
          );
        });
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
      textInputType: TextInputType.number,
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
      textInputType: TextInputType.number,
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
      textInputType: TextInputType.emailAddress,
    );
  }

  Widget secondNameController() {
    return TextFieldApp(
      controller: _secondNameController,
      hintText: "Enter sur name",
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
