import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forte_life/app/colors.dart';
import 'package:forte_life/app/dimen.dart';
import 'package:forte_life/ui/screens/main/main_screen.dart';
import 'package:forte_life/ui/widget/app_bar.dart';
import 'package:forte_life/ui/widget/connectivity_scaffold.dart';
import 'package:forte_life/utils/constants/asset_images.dart';
import 'package:forte_life/utils/constants/strings.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentErrorScreen extends StatelessWidget {
  const PaymentErrorScreen({Key key, this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return ConnectivityScaffold(
      appBar: BaseAppBar("${Strings.program} «$title»"),
      body: Padding(
        padding: const EdgeInsets.all(StandardDimensions.edge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              AssetsImages.ic_error,
              height: kToolbarHeight,
              width: kToolbarHeight,
            ),
            const SizedBox(height: 24),
            Text(
              'Зверніть увагу!',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Під час операції сталася помилка.',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                color: StandardColors.primaryColor,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'На жаль, оплату за договором страхування не виконано.',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                color: StandardColors.primaryColor,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Можливі причини:\n'
              'Ліміт на картці\n'
              'Недостатньо коштів на рахунку',
              style: GoogleFonts.roboto(),
            ),
            const SizedBox(height: 24),
            RaisedButton(
              onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => MainScreen(),
                ),
                (route) => false,
              ),
              padding: EdgeInsets.zero,
              child: SizedBox(
                height: 56,
                child: Center(
                  child: Text('На головну'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
