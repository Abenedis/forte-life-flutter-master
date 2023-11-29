import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forte_life/app/colors.dart';
import 'package:forte_life/app/dimen.dart';
import 'package:forte_life/ui/screens/profile/profile_screen.dart';
import 'package:forte_life/ui/screens/web/web_screen.dart';
import 'package:forte_life/utils/constants/asset_images.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({Key key, this.title}) : super(key: key);
  final String title;

  static const String payment_url =
      'https://forte-life.com.ua/ua/pay/?mobile=1';

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: title,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        leadingWidth: 80,
        leading: Padding(
          padding: const EdgeInsets.only(left: StandardDimensions.edge),
          child: SvgPicture.asset(
            AssetsImages.ic_logo,
          ),
        ),
        actions: [
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
                  MaterialPageRoute<void>(builder: (_) => ProfileScreen()),
                );
              },
              child: SvgPicture.asset(
                AssetsImages.ic_profile,
              ),
            ),
          ),
        ],
        automaticallyImplyLeading: false,
        brightness: Brightness.dark,
        centerTitle: true,
        elevation: 0.0,
        titleSpacing: 0.0,
        backgroundColor: StandardColors.primaryColor,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
