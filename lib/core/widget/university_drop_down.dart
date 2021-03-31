import 'package:flutter/material.dart';

class UniversityDropDown extends StatelessWidget {
  final String hintText;
  final bool isExpandedDropDown;
  final String type;
  final Function valueChanged;
  final List<DropdownMenuItem<String>> items;
  final Color dropdownColor;
  final int elevation;
  final Widget icon;

//  final dynamic value;

  const UniversityDropDown(
      {Key key,
      this.hintText,
      this.isExpandedDropDown,
      this.type,
      this.valueChanged,
      this.items,
      this.dropdownColor,
      this.elevation,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        hint: Text(
          hintText,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        items: items,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        isExpanded: isExpandedDropDown,
        onChanged: valueChanged,
        elevation: elevation,
      ),
    );
  }
}
