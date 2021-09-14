import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:university/core/widget/app_bar.dart';
import 'package:university/features/collage_profile/data/models/collage_profile.dart';
import 'package:university/features/collage_profile/presentation/pages/show_material_files.dart';
import 'package:university/features/collage_profile/presentation/widgets/material_card.dart';
import 'package:university/features/collage_profile/presentation/widgets/simple_card.dart';

class ShowDepartmentMaterial extends StatelessWidget {
  final Department department;
  ShowDepartmentMaterial({this.department});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(
            centerTitle: false,
            context: context,
            widget: Text(department.name)),
        body: ListView.builder(
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ShowMaterialFiles(
                            filesElements: department.subjects[index].files,
                          )));
                },
                child: MaterialCard(
                  description: department?.subjects[index]?.description ??
                      "No Description",
                  title: department?.subjects[index]?.name ?? "No title",
                  numberOfMaterial:
                      department?.subjects[index]?.files?.length ?? 0,
                ),
              );
            },
            itemCount: department.subjects.length));
  }
}
