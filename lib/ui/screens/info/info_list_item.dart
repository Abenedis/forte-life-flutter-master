import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forte_life/app/colors.dart';
import 'package:forte_life/app/dimen.dart';
import 'package:forte_life/core/models/info_model.dart';
import 'package:forte_life/main.dart';
import 'package:forte_life/ui/screens/web/web_screen.dart';
import 'package:forte_life/ui/screens/web/web_screen_cache.dart';
import 'package:forte_life/ui/widget/network_svg.dart';
import 'package:forte_life/utils/constants/api_constants.dart';

class InfoListItem extends StatelessWidget {
  const InfoListItem(this.info, {Key key}) : super(key: key);
  final Info info;

  @override
  Widget build(BuildContext context) {
    var itemBorderRadius = const Radius.circular(12);
    double itemHeight = 80;
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
          onTap: () async {
            connectivity.checkConnectivity().then(
              (value) {
                if (value == ConnectivityResult.none) {
                  Navigator.of(context).push<void>(
                    MaterialPageRoute<void>(
                      builder: (_) => WebScreenCache(
                        title: info.name,
                        objectId: info.id,
                        isWithPadding: true,
                      ),
                    ),
                  );
                } else {
                  Navigator.of(context).push<void>(
                    MaterialPageRoute<void>(
                      builder: (_) => WebScreen(
                        title: info.name,
                        url: info.externalUrl.isEmpty
                            ? (ApiConstants.single_info_url +
                                info.id.toString())
                            : info.externalUrl,
                        isCallback: info.callback,
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
          Radius itemBorderRadius, double itemHeight, BuildContext context) =>
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
              padding: EdgeInsets.symmetric(vertical: itemHeight / 4),
              child: info.isFromCache
                  ? SvgPicture.asset(
                      'assets/info/${info.id}.svg',
                      width: itemHeight,
                      height: itemHeight,
                      color: StandardColors.accentColor,
                      fit: BoxFit.contain,
                    )
                  : NetworkSvg(
                      url: info.iconUrl,
                      width: itemHeight,
                      height: itemHeight,
                      color: StandardColors.accentColor,
                      fit: BoxFit.contain,
                    ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                info.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.start,
              ),
            ),
          )
        ],
      );
}
