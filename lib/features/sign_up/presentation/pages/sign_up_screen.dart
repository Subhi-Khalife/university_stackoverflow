import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/features/university_with_collage/presentation/bloc/bloc/university_bloc.dart';
import '../../../../core/widget/app_button.dart';
import '../../../../core/widget/colors.dart';
import '../../../../core/widget/config_screeen.dart';
import '../../../../core/widget/constant.dart';
import '../../../../core/widget/font_style.dart';
import '../../../../core/widget/text_field_app.dart';
import '../bloc/sign_up/sign_up_bloc.dart';

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
  TextEditingController _passwordNameController;
  TextEditingController _confirmPasswordController;
  TextEditingController _phoneNumberController;
  TextEditingController _collageNumberContoller;
  SignUpBloc signUpBloc;
  UniversityBloc universityBloc;
  String _selectedUniversity;
  String _selectedCollage;
  String universityName;
  String collageName;
  int _universityIndex;

  @override
  void initState() {
    super.initState();
    signUpBloc = SignUpBloc();
    universityBloc = UniversityBloc();
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
    _firstNameController.dispose();
    _secondNameController.dispose();
    _emailNameController.dispose();
    _passwordNameController.dispose();
    _confirmPasswordController.dispose();
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
            if (state is SuccessSignUp) {
              print("Done");
              return Container(
                color: Colors.green,
              );
            } else if (state is LoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: colorThemApp,
                ),
              );
            } else {
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
                  dropDownCollage(),
                  SizedBox(height: 10),
                  passwordController(),
                  SizedBox(height: 10),
                  confirmPasswordController(),
                  SizedBox(height: 10),
                  AppButton(
                    function: () {
                      BlocProvider.of<SignUpBloc>(context)
                        ..add(
                          SendSignUpRequestEvent(
                            collageNumber: _collageNumberContoller.text,
                            email: _emailNameController.text,
                            lastName: _secondNameController.text,
                            firstName: _firstNameController.text,
                            mobile: _phoneNumberController.text,
                            password: _passwordNameController.text,
                            collegeId: 6,
                            universityId: 6,
                          ),
                        );
                    },
                    name: "Sign up",
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget dropDownCollage() {
    return
//      BlocProvider(
//      (context) => universityBloc,
//      child:
        BlocBuilder<UniversityBloc, UniversityState>(builder: (context, state) {
      if (state is UniversityIsLoadedState) {
        print("Done");
        return DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            hint: Text(
              "الجامعة",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            isExpanded: true,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            onChanged: (String newValue) {
              setState(() {
                _selectedUniversity = newValue;
                print("the select is $_selectedUniversity");
              });
            },
            value: _selectedUniversity,
            icon: Icon(
              Icons.arrow_downward,
              color: Colors.grey,
            ),
            items: state.university.data.map(
              (e) {
                return DropdownMenuItem<String>(
                  child: Text(e.name),
                  value: e.id.toString(),
                  onTap: () {
                    setState(() {
                      _selectedCollage = null;
                      _universityIndex = e.id;
                      universityName = e.name;
                    });
                  },
                );
              },
            ).toList(),
            dropdownColor: Colors.red,
            elevation: 5,
          ),
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
    });
//    );
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
