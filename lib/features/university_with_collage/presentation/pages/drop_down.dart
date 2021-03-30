import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/core/widget/colors.dart';
import 'package:university/core/widget/constant.dart';
import 'package:university/core/widget/font_style.dart';
import 'package:university/features/university_with_collage/presentation/bloc/bloc/university_bloc.dart';

class DropDown extends StatefulWidget {
  final List<DropDownItem> dropDownListItem;
  final bool isOpened;
  final String title;
  final bool universitySelecetd;
  DropDown({
    @required this.dropDownListItem,
    this.isOpened = false,
    @required this.title,
    this.universitySelecetd,
  });
  @override
  State<StatefulWidget> createState() {
    return _DropDown();
  }
}

class _DropDown extends State<DropDown> with TickerProviderStateMixin {
  bool isSelected;
  @override
  void initState() {
    super.initState();
    isSelected = widget.isOpened;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        showTitle(),
        showBody(),
      ],
    );
  }

  Widget showBody() {
    return AnimatedSize(
      duration: Duration(milliseconds: 500),
      vsync: this,
      child: SizedBox(
        height: (isSelected) ? 100 : 0,
        width: MediaQuery.of(context).size.width,
        child: Card(
          semanticContainer: false,
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    setState(() {
                      isSelected = !isSelected;
                    });
                    if (widget.universitySelecetd == true) {
                      BlocProvider.of<UniversityBloc>(context)
                        ..add(SelectedUniversityEvent(
                          universityName: widget.dropDownListItem[index].title,
                          
                          universityId: widget.dropDownListItem[index].id,

                          index: index
                        ));
                    } else {
                      BlocProvider.of<UniversityBloc>(context)
                        ..add(SelectedCollageEvent(
                          collageName: widget.dropDownListItem[index].title,
                          collageIndex: widget.dropDownListItem[index].id,
                        ));
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 6,
                        top: (index == 0) ? 0 : 7,
                        bottom: (index == widget.dropDownListItem.length - 1)
                            ? 15
                            : 7),
                    child: Text(
                      widget.dropDownListItem[index].title,
                      style: boldStyle(
                          fontSize: Constant.mediumFont, color: firstColor),
                    ),
                  ));
            },
            itemCount: widget.dropDownListItem.length,
          ),
        ),
      ),
    );
  }

  Widget showTitle() {
    return Container(
      color: Colors.white,
      child: Card(
        child: InkWell(
            onTap: () {
              setState(
                () {
                  isSelected = !isSelected;
                },
              );
            },
            child: Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8, left: 6, right: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: regularStyle(
                        fontSize: Constant.mediumFont, color: firstColor),
                  ),
                  Icon(Icons.vertical_align_bottom)
                ],
              ),
            )),
      ),
    );
  }
}

class DropDownItem {
   String title;
   int id;
  DropDownItem({@required this.id, @required this.title});
}
