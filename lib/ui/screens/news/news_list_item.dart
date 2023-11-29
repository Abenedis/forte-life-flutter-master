import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forte_life/app/colors.dart';
import 'package:forte_life/app/dimen.dart';
import 'package:forte_life/core/models/news_model.dart';
import 'package:forte_life/ui/screens/web/web_screen.dart';
import 'package:forte_life/ui/screens/web/web_screen_cache.dart';
import 'package:forte_life/ui/widget/loading.dart';
import 'package:forte_life/utils/constants/api_constants.dart';

import '../../../main.dart';

class NewsListItem extends StatelessWidget {
  const NewsListItem(this.news, {Key key}) : super(key: key);
  final News news;

  @override
  Widget build(BuildContext context) {
    var itemBorderRadius = const Radius.circular(12);
    double itemHeight = 90;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: StandardDimensions.edge,
        vertical: StandardDimensions.smaller,
      ),
      child: Ink(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.5),
              blurRadius: 10.0, // soften the shadow
            )
          ],
          color: StandardColors.accentColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(itemBorderRadius),
        ),
        child: InkWell(
          onTap: () {
            connectivity.checkConnectivity().then(
              (value) {
                if (value == ConnectivityResult.none) {
                  Navigator.of(context).push<void>(
                    MaterialPageRoute<void>(
                      builder: (_) => WebScreenCache(
                        title: news.name,
                        objectId: news.pageId,
                        isWithPadding: true,
                        path: 'news',
                      ),
                    ),
                  );
                } else {
                  Navigator.of(context).push<void>(
                    MaterialPageRoute<void>(
                      builder: (_) => WebScreen(
                        title: news.name,
                        url: ApiConstants.single_info_url +
                            news.pageId.toString(),
                      ),
                    ),
                  );
                }
              },
            );
          },
          borderRadius: BorderRadius.all(itemBorderRadius),
          child: SizedBox(
            height: itemHeight,
            child: _buildContent(itemBorderRadius, itemHeight, context),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
    Radius itemBorderRadius,
    double itemHeight,
    BuildContext context,
  ) =>
      Row(
        children: [
          Ink(
            decoration: BoxDecoration(
              color: StandardColors.primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: itemBorderRadius,
                topLeft: itemBorderRadius,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: news.isFromCache
                        ? Image.asset(
                            'assets/news/${news.pageId}.png',
                            width: itemHeight / 2,
                            height: itemHeight / 2,
                            color: StandardColors.accentColor,
                            fit: BoxFit.contain,
                          )
                        : news.iconUrl.endsWith('.svg')
                            ? SvgPicture.network(
                                news.iconUrl,
                                width: itemHeight / 2,
                                height: itemHeight / 2,
                                placeholderBuilder: (_) => Loading(),
                                color: StandardColors.accentColor,
                              )
                            : CachedNetworkImage(
                                width: itemHeight / 2,
                                height: itemHeight / 2,
                                filterQuality: FilterQuality.high,
                                placeholder: (context, url) => Loading(),
                                imageUrl: news.iconUrl ?? '',
                                fit: BoxFit.contain,
                                errorWidget: (_, __, dynamic e) => Icon(
                                  Icons.broken_image,
                                  color: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.75),
                                  size: itemHeight * 0.5,
                                ),
                              ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        _buildDateView(),
                        style: TextStyle(
                          fontSize: 9,
                          color: StandardColors.accentColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Flexible(
                    child: RichText(
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: news.shortDescription,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      );

  String _buildDateView() {
    final date = DateTime.fromMillisecondsSinceEpoch(news.timestamp * 1000);
    return '${_twoDigits(date.day)}.${_twoDigits(date.month)}.${date.year}';
  }

  String _twoDigits(int n) {
    if (n >= 10) {
      return '$n';
    }
    return '0$n';
  }
}
