import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forte_life/app/colors.dart';
import 'package:forte_life/app/dimen.dart';
import 'package:forte_life/core/models/program/content_data.dart';
import 'package:forte_life/ui/screens/web/web_screen.dart';
import 'package:forte_life/utils/constants/strings.dart';

class ProgramDetailContent extends StatelessWidget {
  const ProgramDetailContent({
    Key key,
    this.content,
    this.programName = '',
  }) : super(key: key);
  final String programName;
  final ContentData content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CachedNetworkImage(
          filterQuality: FilterQuality.high,
          imageUrl: content.banner,
          width: double.infinity,
          memCacheHeight: 200,
          fit: BoxFit.fitWidth,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: StandardDimensions.edge,
          ),
          child: Column(
            children: content.icons
                .map<Widget>(
                  (e) => _LeadingText(
                    e.title,
                    e.icon,
                  ),
                )
                .toList(),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: StandardDimensions.edge),
          child: Text(
            content.text,
            style: TextStyle(
              fontSize: StandardDimensions.text_big,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(StandardDimensions.edge),
          child: TextButton(
            child: Row(
              children: [
                Text(
                  Strings.more,
                  style: TextStyle(color: StandardColors.primaryColor),
                ),
                Icon(Icons.arrow_forward, color: StandardColors.primaryColor),
              ],
            ),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => WebScreen(
                  title: "${Strings.program} «$programName»",
                  url: content.url,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LeadingText extends StatelessWidget {
  const _LeadingText(this.text, this.image, {Key key}) : super(key: key);
  final String text;
  final String image;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text ?? ''),
      leading: SizedBox(
        height: 45,
        width: 45,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: _isSvg
              ? SvgPicture.network(image)
              : CachedNetworkImage(
                  filterQuality: FilterQuality.high,
                  imageUrl: image ?? '',
                ),
        ),
      ),
    );
  }

  bool get _isSvg => image.endsWith('.svg');
}
