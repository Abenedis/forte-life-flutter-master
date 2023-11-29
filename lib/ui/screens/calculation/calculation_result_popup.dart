import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:forte_life/app/colors.dart';
import 'package:forte_life/app/dimen.dart';
import 'package:forte_life/core/models/label_model.dart';
import 'package:forte_life/core/models/program_calculation_response_model.dart';
import 'package:forte_life/utils/constants/strings.dart';
import 'package:google_fonts/google_fonts.dart';

class CalculationResult extends StatelessWidget {
  CalculationResult({
    this.calculationResponse,
    this.onPressed,
  });

  final CalculationResponse calculationResponse;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(StandardDimensions.edge),
          child: Scaffold(
            backgroundColor: StandardColors.accentColor,
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: calculationResponse.image,
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                    filterQuality: FilterQuality.high,
                    memCacheHeight: 150,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(StandardDimensions.edge),
                    child: Text(
                      calculationResponse.title,
                      style: GoogleFonts.roboto(
                        fontSize: StandardDimensions.text_big_title,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(StandardDimensions.edge)
                        .copyWith(top: 0),
                    child: Text(
                      'Умови страхування',
                      style: GoogleFonts.roboto(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      children: <Widget>[
                        for (int i = 0;
                            i < calculationResponse.labels.length;
                            i++)
                          Ink(
                            color: (i % 2 == 0)
                                ? StandardColors.popupDivider
                                : null,
                            child: LabelWidget(
                              calculationResponse.labels[i],
                            ),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: StandardDimensions.edge,
                    ),
                    child: RaisedButton(
                      onPressed: onPressed,
                      padding: EdgeInsets.zero,
                      child: SizedBox(
                        height: 56,
                        child: Center(
                          child: Text(Strings.Continue),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: StandardDimensions.edge),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: StandardDimensions.edge,
                    ),
                    child: OutlineButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      borderSide: BorderSide(
                        color: StandardColors.selectedColor,
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                      textColor: StandardColors.selectedColor,
                      highlightedBorderColor: StandardColors.selectedColor,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      padding: EdgeInsets.zero,
                      child: SizedBox(
                        height: 56,
                        child: Center(
                          child: Text(Strings.change),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: StandardDimensions.edge),
                ],
              ),
            ),
          ),
        ),
      );
}

class LabelWidget extends StatelessWidget {
  final Label label;

  LabelWidget(this.label);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: StandardDimensions.edge,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                label.name ?? '',
                style: GoogleFonts.roboto(fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(width: 4.0),
            Flexible(
              child: Text(
                label.value ?? '',
                style: GoogleFonts.roboto(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      );
}
