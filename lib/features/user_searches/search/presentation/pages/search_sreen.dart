import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/features/user_searches/search/presentation/bloc/search_bloc/search_bloc.dart';

import '../../../../../core/widget/colors.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchBloc searchBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchBloc = SearchBloc()
      ..add(
        FetchingSearchInfoEvent(),
      );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => searchBloc,
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is FailedGettingSearchInfoState) {
              print("Done");
              return Container(
                color: Colors.red,
              );
            } else if (state is LoadingSearchInfoState) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: colorThemApp,
                ),
              );
            } else if (state is SuccessGettingSearchInfoState) {
              final search = state.searchModel.data;
              print("${search.length}");
              return Container(
                height: 200,
                child: ListView(
                  children: search
                      .map(
                        (e) => Center(
                            child: Text(
                          e.searchText ?? "Null",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 25,
                          ),
                        )),
                      )
                      .toList(),
                ),
              );
            } else {
              return Container(
                color: Colors.orangeAccent,
              );
            }
          },
        ),
      ),
    );
  }
}
