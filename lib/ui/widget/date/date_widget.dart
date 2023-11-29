import 'package:flutter/material.dart';
import 'package:forte_life/app/dimen.dart';
import 'package:forte_life/utils/constants/strings.dart';

import 'date_controlled.dart';

class DateWidget extends StatefulWidget {
  const DateWidget({
    Key key,
    this.controller,
    this.title = '',
  }) : super(key: key);

  final DateController controller;
  final String title;

  @override
  _DateWidgetState createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  FocusNode _dayFocus;
  FocusNode _monthFocus;
  FocusNode _yearFocus;
  @override
  void initState() {
    _dayFocus = FocusNode();
    _monthFocus = FocusNode();
    _yearFocus = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title),
        SizedBox(
          height: StandardDimensions.smaller,
          width: StandardDimensions.smaller,
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: widget.controller.dayTec,
                focusNode: _dayFocus,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                maxLength: 2,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_monthFocus),
                onChanged: (value) {
                  if (value.isNotEmpty) _validate();
                  if (value.length == 2) {
                    FocusScope.of(context).requestFocus(_monthFocus);
                  }
                },
                decoration: InputDecoration(
                  labelText: Strings.day,
                  hintText: DateTime.now().day.toString(),
                  counterText: '',
                ),
              ),
            ),
            SizedBox(
              height: StandardDimensions.smaller,
              width: StandardDimensions.smaller,
            ),
            Expanded(
              child: TextFormField(
                controller: widget.controller.monthTec,
                focusNode: _monthFocus,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                maxLength: 2,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_yearFocus),
                onChanged: (value) {
                  if (value.isNotEmpty) _validate();

                  if (value.length == 2) {
                    FocusScope.of(context).requestFocus(_yearFocus);
                  }
                },
                decoration: InputDecoration(
                  labelText: Strings.month,
                  hintText: DateTime.now().month.toString(),
                  counterText: '',
                ),
              ),
            ),
            SizedBox(
              height: StandardDimensions.smaller,
              width: StandardDimensions.smaller,
            ),
            Expanded(
              child: TextFormField(
                controller: widget.controller.yearTec,
                focusNode: _yearFocus,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                maxLengthEnforced: true,
                maxLength: 4,
                onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                onChanged: (value) {
                  if (value.isNotEmpty) _validate();
                  if (value.length == 4) {
                    FocusScope.of(context).unfocus();
                  }
                },
                decoration: InputDecoration(
                  labelText: Strings.year,
                  hintText: DateTime.now().year.toString(),
                  counterText: '',
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: StandardDimensions.smaller * 0.5,
          width: StandardDimensions.smaller,
        ),
        StreamBuilder<String>(
          stream: widget.controller.validationError,
          initialData: '',
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.data.isNotEmpty)
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                child: Text(
                  snapshot.data,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.red,
                  ),
                ),
              );
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  void _validate() {
    if (widget.controller.dayTec.text.isNotEmpty &&
        widget.controller.monthTec.text.isNotEmpty &&
        widget.controller.yearTec.text.isNotEmpty) {
      widget.controller.validate();
    }
  }

  @override
  void dispose() {
    _dayFocus?.dispose();
    _monthFocus?.dispose();
    _yearFocus?.dispose();
    super.dispose();
  }
}
