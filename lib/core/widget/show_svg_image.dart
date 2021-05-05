import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class showSvgImage extends StatelessWidget {
  String svgPath;
  double width;
  double height;
  BoxFit fit;
  Color coloSvg;
  Function function;
  Alignment alignment;

  showSvgImage({
    @required this.svgPath,
    this.alignment,
    this.width,
    this.height,
    this.function,
    this.fit,
    this.coloSvg,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: SvgPicture.asset(
        svgPath,
        height: height,
        alignment: alignment ?? Alignment.center,
        width: width,
        fit: fit ?? BoxFit.contain,
        color: coloSvg,
      ),
    );
  }
}

class NetworkSvgView extends StatelessWidget {
  String svgPath;
  Function function;

  NetworkSvgView({@required this.svgPath, this.function});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function ?? () {},
      child: SvgPicture.network(svgPath),
    );
  }
}
