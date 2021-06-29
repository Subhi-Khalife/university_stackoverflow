import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:university/core/unified_api/constant_info.dart';
import 'package:university/core/widget/constant.dart';

import 'colors.dart';

class CachedNetworkImageView extends StatelessWidget {
  final String url;
  final Function function;
  final bool witRaduis;
  final withBaseUrl;
  CachedNetworkImageView(
      {this.url = "", this.function, this.witRaduis = false, this.withBaseUrl = true});
  @override
  Widget build(BuildContext context) {
    String _sendUrl = "";
    if (withBaseUrl)
      _sendUrl = ConstantApiInfo.baseUrl + url;
    else {
      _sendUrl = url;
    }
    return InkWell(
      onTap: function,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular((witRaduis) ? 12 : 0)),
        child: CachedNetworkImage(
          imageUrl: _sendUrl,
          fit: BoxFit.cover,
          placeholder: (context, imageUrl) => Center(
              child: CircularProgressIndicator(
            backgroundColor: colorThemApp,
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
          )),
          errorWidget: (context, imageUrl, error) => Container(
            color: Colors.white,
            child: Container(
              color: Colors.white,
              child: Center(child: Icon(Icons.person)),
            ),
          ),
        ),
      ),
    );
  }
}
//
