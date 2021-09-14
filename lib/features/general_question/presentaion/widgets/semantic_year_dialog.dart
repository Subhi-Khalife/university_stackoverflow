import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/core/entities/search_model.dart';
import 'package:university/core/widget/bloc_error_screen.dart';
import 'package:university/core/widget/container_app_decoration.dart';
import 'package:university/core/widget/drop_down_text_field.dart';
import 'package:university/core/widget/loading_view.dart';
import 'package:university/core/widget/search_dialog.dart';
import 'package:university/features/general_question/data/models/filter_model.dart';
import 'package:university/features/general_question/data/models/year_semester_model.dart';
import 'package:university/features/general_question/presentaion/bloc/bloc/general_question_bloc.dart';

class SemanticYearDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SemanticYearDialog();
  }
}

// ignore: must_be_immutable
class _SemanticYearDialog extends State<SemanticYearDialog> {
  GeneralQuestionBloc generalQuestionBloc;
  FilterModel filterModel = FilterModel();
  YearSemesterModel yearSemesterModel = YearSemesterModel();
  TextEditingController semanticController;
  TextEditingController yearController;
  int semanticId = -1;
  @override
  void initState() {
    super.initState();
    generalQuestionBloc = GeneralQuestionBloc();
    generalQuestionBloc.add(GetFilters());
    semanticController = TextEditingController();
    yearController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider<GeneralQuestionBloc>(
      create: (context) => generalQuestionBloc,
      child: BlocListener<GeneralQuestionBloc, GeneralQuestionState>(
        listener: (context, state) {
          if (state is SuccessGetAllFilter)
            filterModel = state.filterModel;
          else if (state is SuccessGetAllYearSemantic)
            yearSemesterModel = state.searSemesterModel;
        },
        child: BlocBuilder<GeneralQuestionBloc, GeneralQuestionState>(
          builder: (context, state) {
            if (state is LoadingStateGeneralQuestion) {
              return LoadingView();
            } else if (state is FailedGetAllFilter) {
              return BlocErrorScreen(
                function: () {
                  generalQuestionBloc.add(GetFilters());
                },
              );
            } else {
              return Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Center(
                  child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: containerDecoration(),
                      child: Column(
                        children: [
                          DropDownTextField(
                              hintText: 'select your sematic',
                              errorText: "This field required",
                              handleTap: () {
                                _habdleGetAllTabs();
                              })
                        ],
                      )),
                ),
              );
            }
          },
        ),
      ),
    ));
  }

  void _habdleGetAllTabs() {
    List<SearchModel> seachItems = [];
    seachItems.clear();

    for (int i = 0; i < filterModel.data.semesters.length; i++) {
      seachItems.add(SearchModel(
        id: filterModel.data.semesters[i].id,
        name: filterModel.data.semesters[i].semester,
      ));
    }
    showDialog(
        context: context,
        builder: (context) => SearchDialog(
              data: seachItems,
            )).then(
      (val) {
        if (val != null) {
          semanticController.text = seachItems[val].name;
          semanticId = seachItems[val].id;
        }
      },
    );
  }


}
