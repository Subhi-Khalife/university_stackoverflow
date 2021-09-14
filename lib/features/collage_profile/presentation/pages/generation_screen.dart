import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:university/features/collage_profile/data/models/collage_profile.dart';
import 'package:university/features/collage_profile/presentation/widgets/department_card.dart';
import 'package:university/features/collage_profile/presentation/widgets/simple_card.dart';

class GenerationScreen extends StatelessWidget {
  final List<Generation> generationList;
  GenerationScreen({this.generationList});
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 3,
      children: generationList.map((e) {
        return SimpleCard(
          id: e.id,
          name: e.name,
        );
      }).toList(),
    );
  }
}
