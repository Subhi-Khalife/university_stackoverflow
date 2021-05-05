import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'colors.dart';

class CachedNetworkImageView extends StatelessWidget {
  final String url;
  final Function function;
  CachedNetworkImageView({this.url = "", this.function});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        placeholder: (context, imageUrl) => Center(
            child: CircularProgressIndicator(
          backgroundColor: colorThemApp,
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
        )),
        errorWidget: (context, imageUrl, error) => Container(
          color: Colors.white,
//          client.svg
          child: SvgPicture.asset(
            'lib/svgFiles/client.svg',
            semanticsLabel: 'client',
          ),
        ),
      ),
    );
  }
}
//
