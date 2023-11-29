import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forte_life/app/colors.dart';
import 'package:forte_life/ui/screens/contact/contact_screen.dart';
import 'package:forte_life/utils/constants/asset_images.dart';

class InfoFab extends StatelessWidget {
  const InfoFab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: SvgPicture.asset(AssetsImages.ic_chat),
      backgroundColor: StandardColors.primaryColor,
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ContactScreen(),
        ),
      ),
    );
  }
}
