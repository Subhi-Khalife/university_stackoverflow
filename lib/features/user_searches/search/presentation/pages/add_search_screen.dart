import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/core/widget/app_button.dart';
import 'package:university/core/widget/colors.dart';
import 'package:university/core/widget/text_field_app.dart';
import 'package:university/features/user_searches/search/presentation/bloc/add_search_bloc/postsearch_bloc.dart';

class AddSearchScreen extends StatefulWidget {
  @override
  _AddSearchScreenState createState() => _AddSearchScreenState();
}

class _AddSearchScreenState extends State<AddSearchScreen> {
  TextEditingController _emailController;

  PostsearchBloc postsearchBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
    postsearchBloc = PostsearchBloc();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    postsearchBloc.close();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 15,
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
              loginButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginButton() {
    return BlocProvider<PostsearchBloc>(
      create: (context) => postsearchBloc,
      child: BlocBuilder<PostsearchBloc, PostsearchState>(
        builder: (context, state) {
          print("the current state is $state");
          if (state is SuccessSendingPostsearchState) {
            final feedbackInstance = state.addSearchModel.data[0].searchText;
            print("Done");
            return Container(
              height: 100,
              width: 100,
              child: Text(
                feedbackInstance,
              ),
            );
          } else if (state is LoadingPostsearchState) {
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
                BlocProvider.of<PostsearchBloc>(context)
                  ..add(
                    SendingAddSearchEvent(
                      searchText: _emailController.text,
                    ),
                  );
              },
              name: "Search",
            );
          }
        },
      ),
    );
  }
}
