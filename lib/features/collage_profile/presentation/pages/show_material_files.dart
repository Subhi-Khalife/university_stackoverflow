import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:university/core/widget/app_bar.dart';
import 'package:university/features/collage_profile/data/models/collage_profile.dart';
import 'package:university/features/collage_profile/presentation/widgets/download_file.dart';

class ShowMaterialFiles extends StatelessWidget {
  final List<FileElement> filesElements;
  ShowMaterialFiles({this.filesElements});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(
            centerTitle: false,
            context: context,
            widget: Text("Files Details")),
        body: ListView.builder(
            itemBuilder: (context, index) {
              String formattedDate = DateFormat('yyyy-MM-dd')
                  .format(filesElements[index].createdAt);
              return DownloadFile(
                description: formattedDate ?? "No Description",
                title: filesElements[index]?.name ?? "No title",
                url: filesElements[index]?.url,
              );
            },
            itemCount: filesElements.length));
  }
}
