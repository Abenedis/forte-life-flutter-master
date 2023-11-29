import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forte_life/core/models/program/field_object.dart';
import 'package:forte_life/core/models/program/filed_select_data.dart';
import 'package:forte_life/utils/constants/strings.dart';
import 'package:forte_life/utils/validator.dart';

class SelectorWidget extends StatelessWidget {
  const SelectorWidget({
    Key key,
    this.divider,
    this.data,
    this.title,
    this.onChange,
  }) : super(key: key);
  final Widget divider;
  final FieldObject data;
  final String title;
  final ValueSetter<FieldSelectData> onChange;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title),
        divider,
        DropdownButtonFormField(
          decoration: InputDecoration(hintText: Strings.choose),
          validator: (FieldSelectData data) =>
              Validator.empty(data?.name ?? ''),
          items: data.fields
              .map((FieldSelectData value) => DropdownMenuItem<FieldSelectData>(
                    value: value,
                    child: new Text(value.name),
                  ))
              .toList(),
          onChanged: onChange,
          onTap: () => FocusScope.of(context).unfocus(),
        ),
      ],
    );
  }
}
