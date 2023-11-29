import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forte_life/app/colors.dart';
import 'package:forte_life/core/models/program/filed_select_data.dart';

class RadioButtons extends StatelessWidget {
  const RadioButtons({
    this.onSelect,
    this.first,
    this.second,
    this.selected,
  });

  final FieldSelectData first;
  final FieldSelectData second;
  final ValueSetter<FieldSelectData> onSelect;
  final FieldSelectData selected;

  static const double textPadding = 8.0;

  @override
  Widget build(BuildContext context) {
    bool isFirst = selected == first;
    return Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          width: 2.0,
          color: StandardColors.selectedColor,
        ),
      ),
      child: second == null
          ? InkWell(
              onTap: () {
                onSelect(first);
              },
              child: SizedBox(
                width: double.infinity,
                child: Ink(
                  decoration: BoxDecoration(
                    color: isFirst
                        ? StandardColors.selectedColor
                        : Colors.transparent,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(textPadding),
                    child: Text(
                      first.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isFirst
                            ? StandardColors.accentColor
                            : StandardColors.selectedColor,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      onSelect(first);
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        color: isFirst
                            ? StandardColors.selectedColor
                            : Colors.transparent,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(textPadding),
                        child: Text(
                          first.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isFirst
                                ? StandardColors.accentColor
                                : StandardColors.selectedColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      onSelect(second);
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        color: !isFirst
                            ? StandardColors.selectedColor
                            : Colors.transparent,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(textPadding),
                        child: Text(
                          second.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: !isFirst
                                ? StandardColors.accentColor
                                : StandardColors.selectedColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
