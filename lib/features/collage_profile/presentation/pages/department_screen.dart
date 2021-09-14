import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:university/features/collage_profile/data/models/collage_profile.dart';
import 'package:university/features/collage_profile/presentation/pages/show_department_material.dart';
import 'package:university/features/collage_profile/presentation/widgets/department_card.dart';

class DepartmentScreen extends StatelessWidget {
  final List<Department> listOfDepartmentItem;
  DepartmentScreen({@required this.listOfDepartmentItem});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        padding: EdgeInsets.only(top: 12),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ShowDepartmentMaterial(
                    department: listOfDepartmentItem[index],
                  ),
                ),
              );
            },
            child: DepartmentCard(
              id: listOfDepartmentItem[index].id,
              name: listOfDepartmentItem[index].name,
            ),
          );
        },
        itemCount: listOfDepartmentItem.length,
        separatorBuilder: (context, index) {
          return Divider(
            color: Theme.of(context).accentColor,
          );
        },
      ),
    );
  }
}
