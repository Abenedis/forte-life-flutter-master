import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forte_life/core/models/blinchiki_calculation_result.dart';
import 'package:google_fonts/google_fonts.dart';

import 'blinchik_label.dart';

class BlinchikiContentData extends StatelessWidget {
  const BlinchikiContentData({
    Key key,
    this.result,
    this.lastSum,
  }) : super(key: key);
  final BlinckikiCalculationResult result;
  final int lastSum;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Text(
            'Вартість нерухомості - $lastSum грн',
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        _BlinImage(
          image: result.content.blinchik0.image,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            BlinchikLabel(
              color: Color.fromRGBO(179, 37, 26, 1),
              text: result.calculate.summForte.title,
              values: result.calculate.summForte.number.toString(),
            ),
            BlinchikLabel(
              color: Color.fromRGBO(166, 166, 166, 1),
              text: result.calculate.summ11Personal.title,
              values: result.calculate.summ11Personal.number.toString(),
            ),
            BlinchikLabel(
              color: Color.fromRGBO(241, 241, 241, 1),
              text: result.calculate.summ11Consultant.title,
              values: result.calculate.summ11Consultant.number.toString(),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Text(
            'ЩОМІСЯЧНІ УМОВИ(1-15 місяців)',
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        _BlinImage(
          image: result.content.blinchik1.image,
        ),
        BlinchikLabel(
          color: Color.fromRGBO(251, 81, 21, 1),
          text: result.calculate.payInvest.title,
          values: '',
        ),
        BlinchikLabel(
          color: Color.fromRGBO(251, 81, 21, 1),
          text: result.calculate.payInvest.title2,
          values: result.calculate.payInvest.number.toString(),
        ),
      ],
    );
  }
}

class _BlinImage extends StatelessWidget {
  const _BlinImage({Key key, this.image}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return isSvg
        ? SvgPicture.network(
            image,
            color: Colors.red,
            width: width,
            fit: BoxFit.fitWidth,
          )
        : CachedNetworkImage(
            imageUrl: image,
            width: width,
            fit: BoxFit.fitWidth,
            filterQuality: FilterQuality.high,
          );
  }

  bool get isSvg => image.endsWith('.svg');
}
