import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/core/widget/colors.dart';
import 'package:university/features/tabs/presentation/bloc/bloc/tab_bloc.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  TabBloc tabBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabBloc = TabBloc()..add(FetchTabsEvent());
  }

  @override
  void dispose() {
    super.dispose();
    tabBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => tabBloc,
        child: BlocBuilder<TabBloc, TabState>(
          builder: (context, state) {
            if (state is FailedGettingTabsState) {
              print("Done");
              return Container(
                color: Colors.red,
              );
            } else if (state is LoadingGettingTabsState) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: colorThemApp,
                ),
              );
            } else if (state is SuccessGettingTabsState) {
              final success = state.tabModel.data[0];
              return Center(
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      success.name,
                    ),
                    Text(
                      success.collegeId.toString(),
                    ),
                  ],
                ),
              );
            } else {
              return Container(
                color: Colors.amber,
              );
            }
          },
        ),
      ),
    );
  }
}
