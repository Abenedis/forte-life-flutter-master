import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forte_life/app/colors.dart';

import 'loading.dart';

class NetworkSvg extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final Widget placeholder;
  final Widget onErrorWidget;
  final Color color;
  final BoxFit fit;

  const NetworkSvg(
      {Key key,
      this.url,
      this.width,
      this.height,
      this.placeholder = const Loading(),
      this.onErrorWidget =
          const Icon(Icons.broken_image, color: StandardColors.secondaryColor),
      this.color,
      this.fit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;
    try {
      child = SvgPicture.network(
        url,
        placeholderBuilder: (context) => placeholder,
        color: color,
        fit: fit,
        
      );
    } catch (e) {
      child = onErrorWidget;
    }
    return Container(
      height: height,
      width: width,
      child: child,
    );
  }
}
