import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/core/widget/colors.dart';
import 'package:university/core/widget/show_message.dart';
import 'package:university/features/user_searches/search/data/models/search_model.dart';
import 'package:university/features/user_searches/search/presentation/bloc/search_bloc/search_bloc.dart';

class AllSearchScreen extends StatefulWidget {
  @override
  _AllSearchScreenState createState() => _AllSearchScreenState();
}

class _AllSearchScreenState extends State<AllSearchScreen> {
  SearchBloc searchBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchBloc = SearchBloc();
    searchBloc
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
      appBar: AppBar(
        title: Text("Search App"),
        actions: [
          BlocProvider<SearchBloc>(
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
                  // print("${search}");
                  return IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: DataSearch(searchs: search),
                      );
                    },
                  );
                } else {
                  return Container(
                    color: Colors.orangeAccent,
                  );
                }
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(),
    );
  }
}

class DataSearch extends SearchDelegate<dynamic> {
  final List<Search> searchs;

  final recentLetters = [
    'a',
    'b',
  ];

  DataSearch({this.searchs});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, query);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //final suggestionsList = searchs;
    showMessage(query);

    return Center(
      child: Container(
        child: Card(
          color: Colors.red,
          child: Center(
            child: Text(query),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Search> newSearch = searchs;
    final suggestionsList = query.isEmpty
        ? searchs
        : searchs
            .where(
              (element) => element.searchText.contains(
                RegExp(query, caseSensitive: false),
              ),
            )
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          // searchs.add(suggestionsList[index]);
          showResults(context);
        },
        leading: Icon(
          Icons.location_city,
        ),
        title: RichText(
          text: TextSpan(
              text:
                  suggestionsList[index].searchText.substring(0, query.length),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text:
                      suggestionsList[index].searchText.substring(query.length),
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ]),
        ),
      ),
      itemCount: suggestionsList.length,
    );

    //  ListView.builder(
    //   itemBuilder: (context, index) => ListTile(
    //     onTap: () {
    //       showResults(context);
    //     },
    //     leading: Icon(
    //       Icons.location_city,
    //     ),
    //     title: RichText(
    //       text: TextSpan(
    //           text: suggestionsList[index].substring(0, query.length),
    //           style: TextStyle(
    //             color: Colors.black,
    //             fontWeight: FontWeight.bold,
    //           ),
    //           children: [
    //             TextSpan(
    //               text: suggestionsList[index].substring(query.length),
    //               style: TextStyle(
    //                 color: Colors.grey,
    //               ),
    //             ),
    //           ]),
    //     ),
    //   ),
    //   itemCount: suggestionsList.length,
    // );
  }
}
