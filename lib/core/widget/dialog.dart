import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:university/core/entities/dialog_item.dart';

class DialogView extends StatelessWidget {
  final List<DialogItem> items;
  DialogView({this.items});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 200,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return InkWell(child: Text(items[index].name));
          },
        ),
      ),
    );
  }
}
