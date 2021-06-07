import 'package:flutter/material.dart';
import 'package:university/core/entities/gallery.dart';
import 'package:university/core/widget/constant.dart';
import 'package:university/core/widget/container_app_decoration.dart';
import 'package:university/core/widget/font_style.dart';

import '../../data/models/collage_profile.dart';
import 'gallery_details_page.dart';

class GalleryPage extends StatelessWidget {
  final List<Gallery> galleries;

  const GalleryPage({
    Key key,
    this.galleries,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              "Gallery",
              style: boldStyle(
                  fontSize: Constant.xlargeFont+6,
                  color: Theme.of(context).hintColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: galleries == null
                  ? CircularProgressIndicator(
                      backgroundColor: Colors.red,
                    )
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemBuilder: (context, index) {
                        return RawMaterialButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return GalleryDetailsPage(
                                    gallery: galleries[index],
                                  );
                                },
                              ),
                            );
                          },
                          child: Hero(
                            tag: galleries[index].id,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    galleries[index].logo,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: galleries.length,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
