import 'package:flutter/material.dart';
import 'package:forte_life/utils/constants/strings.dart';
import 'package:forte_life/utils/validator.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({
    Key key,
    this.day,
    this.mounth,
    this.year,
    this.dayFocus,
    this.monthFocus,
    this.yearFocus,
    this.divider,
    this.title,
  }) : super(key: key);
  final Widget divider;
  final TextEditingController day;
  final TextEditingController mounth;
  final TextEditingController year;
  final FocusNode dayFocus;
  final FocusNode monthFocus;
  final FocusNode yearFocus;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title ?? "Дата народження Застрахованої особи"),
        divider,
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: day,
                focusNode: dayFocus,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                maxLength: 2,
                validator: Validator.empty,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(monthFocus),
                decoration: InputDecoration(
                  labelText: Strings.day,
                  counterText: '',
                ),
              ),
            ),
            divider,
            Expanded(
              child: TextFormField(
                controller: mounth,
                focusNode: monthFocus,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                maxLength: 2,
                validator: Validator.empty,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(yearFocus),
                decoration: InputDecoration(
                  labelText: Strings.month,
                  counterText: '',
                ),
              ),
            ),
            divider,
            Expanded(
              child: TextFormField(
                controller: year,
                focusNode: yearFocus,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                maxLengthEnforced: true,
                maxLength: 4,
                validator: Validator.empty,
                decoration: InputDecoration(
                  labelText: Strings.year,
                  counterText: '',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
