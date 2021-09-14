import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/core/widget/app_button.dart';
import 'package:university/core/widget/colors.dart';
import 'package:university/features/user_searches/search/presentation/bloc/del_search_bloc/bloc/delete_bloc.dart';

class DeleteSearchScreen extends StatefulWidget {
  @override
  _DeleteSearchScreenState createState() => _DeleteSearchScreenState();
}

class _DeleteSearchScreenState extends State<DeleteSearchScreen> {
  DeleteBloc deleteSearchBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    deleteSearchBloc = DeleteBloc();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    deleteSearchBloc.close();
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
              loginButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginButton() {
    return BlocProvider<DeleteBloc>(
      create: (context) => deleteSearchBloc,
      child: BlocBuilder<DeleteBloc, DeleteState>(
        builder: (context, state) {
          print("the current state is $state");
          if (state is SuccessSendingDelSearchState) {
            final feedbackInstance = state.delSearchModel;
            print("Done");
            return Container(
              height: 100,
              width: 100,
              child: Text(
                feedbackInstance.message,
              ),
            );
          } else if (state is LoadingDelSearchState) {
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
                BlocProvider.of<DeleteBloc>(context)
                  ..add(
                    SendingDelSearchEvent(),
                  );
              },
              name: "Delete",
            );
          }
        },
      ),
    );
  }
}
