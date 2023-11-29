import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forte_life/app/colors.dart';
import 'package:forte_life/app/dimen.dart';
import 'package:forte_life/core/models/program_model.dart';
import 'package:forte_life/ui/screens/blinchiki/confirm/blinchiki_confirm_screen.dart';
import 'package:forte_life/ui/screens/programs_detail/programs_detail_screen.dart';
import 'package:forte_life/utils/constants/asset_images.dart';

import 'program_item_cached_image.dart';

class ProgramListItem extends StatelessWidget {
  const ProgramListItem(this.program, {Key key}) : super(key: key);
  final Program program;

  @override
  Widget build(BuildContext context) {
    final double itemHeight = 75;
    return InkWell(
      borderRadius: BorderRadius.circular(1000),
      onTap: () {
        Navigator.of(context).push<void>(
          MaterialPageRoute<void>(
            builder: (context) => program.isBlinchiki
                ? BlinchikiConfirmScreen()
                : ProgramDetailsScreen(program: program),
          ),
        );
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: itemHeight * 1.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (program.isPromo)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SvgPicture.asset(AssetsImages.ic_promo),
                        ],
                      ),
                    ),
                  ProgramItemCachedImage(
                    id: program.id,
                    url: program.iconUrl,
                    width: itemHeight,
                    height: itemHeight,
                    color: StandardColors.accentColor,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(StandardDimensions.smaller),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: program.name,
                  style: TextStyle(
                    color: StandardColors.accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
