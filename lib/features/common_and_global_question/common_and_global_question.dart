import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:university/features/general_question/presentaion/pages/show_all_global_posts.dart';
import 'package:university/features/post/presentation/pages/show_all_posts.dart';

class CommonAndGlobalQuestion extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CommonAndGlobalQuestion();
  }
}

class _CommonAndGlobalQuestion extends State<CommonAndGlobalQuestion> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    ShowAllPosts(),
    ShowAllGlobalPosts(),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            label: 'Questions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: 'Public Questions',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Theme.of(context).hintColor,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
