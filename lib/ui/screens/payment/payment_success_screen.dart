import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forte_life/app/dimen.dart';
import 'package:forte_life/ui/screens/main/main_screen.dart';
import 'package:forte_life/ui/widget/app_bar.dart';
import 'package:forte_life/ui/widget/connectivity_scaffold.dart';
import 'package:forte_life/utils/constants/asset_images.dart';
import 'package:forte_life/utils/constants/strings.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({Key key, this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return ConnectivityScaffold(
      appBar: BaseAppBar("${Strings.program} «$title»"),
      body: Padding(
        padding: const EdgeInsets.all(StandardDimensions.edge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              AssetsImages.ic_success,
              height: kToolbarHeight,
              width: kToolbarHeight,
            ),
            const SizedBox(height: 24),
            Text(
              'Шановний клієнте, дякуємо!',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Оплата пройшла успішно.',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Ваш договір страхування направлений на e-mail, що був вказаний в заяві.',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Якщо Ви не отримали листа, прохання перевірити папку "спам".',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
              ),
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
