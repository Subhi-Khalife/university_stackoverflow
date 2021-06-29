import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:university/core/entities/gallery.dart';
import 'package:university/core/widget/app_bar.dart';
import 'package:university/core/widget/cached_newtwok_image_view.dart';
import 'package:university/core/widget/constant.dart';
import 'package:university/core/widget/font_style.dart';
import 'package:university/features/profile/presentation/pages/new_profile_page.dart';
import 'package:university/features/profile/presentation/pages/normal_user_information.dart';

class GalleryDetailsPage extends StatelessWidget {
  final Gallery gallery;
  const GalleryDetailsPage({
    Key key,
    this.gallery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(gallery.createdAt);
    return Scaffold(
      appBar: appBar(
          widget: Text("Project Details"),
          context: context,
          centerTitle: false),
      body: Container(
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width,
              child: Hero(
                tag: gallery.id,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        gallery.logo,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Project name:",
                        style: boldStyle(
                            fontSize: Constant.largeFont,
                            color: Theme.of(context).hintColor),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "${gallery.name}",
                        style: regularStyle(
                            fontSize: Constant.mediumFont,
                            color: Theme.of(context).accentColor),
                      ),
                      SizedBox(height: 8),
                      SizedBox(height: 8),
                      Text(
                        "Project description:",
                        style: boldStyle(
                            fontSize: Constant.largeFont,
                            color: Theme.of(context).hintColor),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "${gallery.description}",
                        style: regularStyle(
                            fontSize: Constant.mediumFont,
                            color: Theme.of(context).accentColor),
                      ),
                      SizedBox(height: 8),
                      SizedBox(height: 8),
                      Text(
                        "Created at :",
                        style: boldStyle(
                            fontSize: Constant.largeFont,
                            color: Theme.of(context).hintColor),
                      ),
                      SizedBox(height: 8),
                      Text(
                        formattedDate,
                        style: regularStyle(
                            fontSize: Constant.mediumFont,
                            color: Theme.of(context).accentColor),
                      ),
                      SizedBox(height: 8),
                      SizedBox(height: 8),
                      gallery.galleryusers != null
                          ? Text(
                              "Prpject team members:",
                              style: boldStyle(
                                  fontSize: Constant.largeFont,
                                  color: Theme.of(context).hintColor),
                            )
                          : Container(),
                      SizedBox(height: 8),
                      gallery.galleryusers != null
                          ? Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Wrap(
                                children: gallery.galleryusers
                                    .map((e) => Padding(
                                          padding: EdgeInsets.only(
                                              left: 3,
                                              right: 3,
                                              bottom: 8,
                                              top: 8),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 100,
                                                  child: CachedNetworkImageView(
                                                    url: e?.user?.profilePic ??
                                                        "",
                                                    witRaduis: true,
                                                    withBaseUrl: false,
                                                    
                                                    function: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  NormalUserProfile(
                                                                      user:  e.user,
                                                                      userId:  e.user.id.toString(),
                                                                      )));
                                                    },
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  e.user.firstName +" "+
                                                      e.user.lastName,
                                                  style: regularStyle(
                                                    fontSize:
                                                        Constant.smallFont,
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                )
                                              ],
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
