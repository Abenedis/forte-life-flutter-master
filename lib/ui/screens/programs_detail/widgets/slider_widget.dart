import 'package:flutter/material.dart';
import 'package:forte_life/app/colors.dart';
import 'package:forte_life/core/models/program/range_num.dart';
import 'custom_slider_thumb_circle.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget({
    Key key,
    this.pay,
    this.value,
    this.onChange,
    this.width = 60,
  }) : super(key: key);

  final RangeNum pay;
  final int value;
  final int width;
  final ValueSetter<int> onChange;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        showValueIndicator: ShowValueIndicator.always,
        trackShape: const RoundedRectSliderTrackShape(),
        trackHeight: 4.0,
        thumbShape: CustomSliderThumbCircle(
          thumbRadius: 25,
          width: width,
          min: pay.min,
          max: pay.max,
        ),
        activeTrackColor: StandardColors.selectedColor,
        valueIndicatorShape: SliderComponentShape.noOverlay,
        tickMarkShape: const RoundSliderTickMarkShape(),
        valueIndicatorTextStyle: const TextStyle(
          color: Colors.black,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 7.0, right: 3),
        child: Slider(
          onChanged: (value) {
            int intValue = (value).round();

            onChange(intValue.roundTo(pay.multiplicity));
          },
          value: value.toDouble(),
          max: pay.max.toDouble(),
          min: pay.min.toDouble(),
        ),
      ),
    );
  }
}

extension IntRound on int {
  int roundTo(int value) => ((this / value).round() * value);
}
