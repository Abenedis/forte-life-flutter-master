import 'package:flutter/material.dart';
import 'package:forte_life/core/models/program/filed_select_data.dart';
import 'package:forte_life/ui/widget/radio_buttons.dart';

class PassportRadio extends StatelessWidget {
  const PassportRadio({
    Key key,
    this.first,
    this.second,
    this.selected,
    this.onSelect,
    this.child,
  }) : super(key: key);
  final FieldSelectData first;
  final FieldSelectData second;
  final FieldSelectData selected;
  final ValueSetter<FieldSelectData> onSelect;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioButtons(
          first: first,
          second: second,
          selected: selected,
          onSelect: onSelect,
        ),
        child,
      ],
    );
  }
}
