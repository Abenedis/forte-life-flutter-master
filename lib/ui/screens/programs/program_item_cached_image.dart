import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProgramItemCachedImage extends StatelessWidget {
  const ProgramItemCachedImage({
    Key key,
    this.url,
    this.id,
    this.height,
    this.width,
    this.fit,
    this.color,
  }) : super(key: key);

  final String url;
  final int id;
  final double height;
  final double width;
  final Color color;
  final BoxFit fit;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.network(
      url,
      height: height,
      width: width,
      fit: fit,
      color: color,
      placeholderBuilder: (ctx) => SvgPicture.asset(
        'assets/programs/$id.svg',
        height: height,
        width: width,
        fit: fit,
        color: color,
      ),
    );
  }
}
