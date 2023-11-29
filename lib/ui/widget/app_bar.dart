import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forte_life/app/dimen.dart';
import 'package:forte_life/ui/screens/profile/profile_screen.dart';
import 'package:forte_life/ui/screens/web/web_screen.dart';
import 'package:forte_life/utils/constants/asset_images.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  static const String payment_url =
      'https://forte-life.com.ua/ua/pay/?mobile=1';

  const BaseAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: AppBar(
        centerTitle: false,
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: title,
            style: TextStyle(fontSize: 20),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: StandardDimensions.edge),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push<void>(
                  MaterialPageRoute<void>(
                    builder: (context) => WebScreen(
                      title: 'Оплата',
                      url: payment_url,
                    ),
                  ),
                );
              },
              child: SvgPicture.asset(
                AssetsImages.ic_payment,
                color: Colors.white,
                height: 30,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: StandardDimensions.edge),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push<void>(
                  MaterialPageRoute<void>(
                      builder: (context) => ProfileScreen()),
                );
              },
              child: SvgPicture.asset(
                AssetsImages.ic_profile,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
