import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/core/widget/app_button.dart';
import 'package:university/core/widget/colors.dart';
import 'package:university/core/widget/text_field_app.dart';
import 'package:university/features/react/presentation/bloc/bloc/react_bloc.dart';

class ReactScreen extends StatefulWidget {
  @override
  _ReactScreenState createState() => _ReactScreenState();
}

class _ReactScreenState extends State<ReactScreen> {
  TextEditingController _emailController;
  TextEditingController _messageController;
  TextEditingController _nameController;

  ReactBloc reactBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
    _messageController = TextEditingController();
    _nameController = TextEditingController();
    reactBloc = ReactBloc();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    reactBloc.close();
    _emailController.dispose();
    _messageController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 15.0,
              ),
              TextFieldApp(
                controller: _emailController,
                hintText: "Enter your email",
                withIcon: true,
                icon: Icons.email,
                isTextFieldPassword: false,
                style: TextStyle(color: Colors.black),
                prefixSvg: "lib/svg/mail_icon.svg",
              ),
              TextFieldApp(
                controller: _messageController,
                hintText: "Enter your email",
                withIcon: true,
                icon: Icons.email,
                isTextFieldPassword: false,
                style: TextStyle(color: Colors.black),
                prefixSvg: "lib/svg/mail_icon.svg",
              ),
              TextFieldApp(
                controller: _nameController,
                hintText: "Enter your email",
                withIcon: true,
                icon: Icons.email,
                isTextFieldPassword: false,
                style: TextStyle(color: Colors.black),
                prefixSvg: "lib/svg/mail_icon.svg",
              ),
              loginButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginButton() {
    return BlocProvider<ReactBloc>(
      create: (context) => reactBloc,
      child: BlocBuilder<ReactBloc, ReactState>(
        builder: (context, state) {
          print("the current state is $state");
          if (state is SuccessSendingReactState) {
            final reactInstance = state.reactModel;
            print("Done");
            return Container(
              height: 100,
              width: 100,
              child: Text(
                reactInstance.msg,
              ),
            );
          } else if (state is LoadingReactState) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: colorThemApp,
              ),
            );
          } else {
            return AppButton(
              buttonColor: Color(0xff315786),
              fontColor: Colors.black,
              elevationValue: 8,
              function: () {
                BlocProvider.of<ReactBloc>(context)
                  ..add(
                    SendingPostReactEvent(
                      commmentId: _emailController.text,
                      postId: _messageController.text,
                      type: _nameController.text,
                    ),
                  );
              },
              name: "SendReact",
            );
          }
        },
      ),
    );
  }
}
