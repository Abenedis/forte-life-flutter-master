import 'package:flutter/material.dart';
import 'package:forte_life/core/models/program/field_object.dart';
import 'package:forte_life/core/models/program/filed_select_data.dart';
import 'package:forte_life/ui/screens/programs_detail/program_detail_bloc.dart';
import 'package:forte_life/ui/widget/radio_buttons.dart';
import 'package:forte_life/utils/constants/strings.dart';
import 'package:forte_life/utils/validator.dart';
import 'package:provider/provider.dart';
import 'slider_widget.dart';

class RadioWidget extends StatelessWidget {
  const RadioWidget({
    Key key,
    this.divider,
    this.field,
    this.selected,
    this.onSelect,
    this.sum,
  }) : super(key: key);

  final Widget divider;
  final FieldObject field;
  final FieldSelectData selected;
  final ValueSetter<FieldSelectData> onSelect;
  final TextEditingController sum;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(field.name),
        divider,
        RadioButtons(
          first: firstField,
          second: secondField,
          selected: selected,
          onSelect: onSelect,
        ),
        divider,
        divider,
        if (selected.isHasPay)
          StreamBuilder<int>(
            stream: context.watch<ProgramDetailBloc>().paySumValue,
            initialData: selected.pay.min,
            builder: (context, snapshot) {
              return SliderWidget(
                pay: selected.pay,
                value: snapshot.data,
                onChange: context.watch<ProgramDetailBloc>().onUpdatePaySum,
              );
            },
          )
        else
          TextFormField(
            controller: sum,
            validator: (value) => Validator.numberWithMin(
              value,
              selected.pay.min,
            ),
            keyboardType: TextInputType.numberWithOptions(),
            decoration: InputDecoration(
              labelText: Strings.sumUAH,
            ),
          ),
      ],
    );
  }

  FieldSelectData get firstField {
    try {
      return field.fields.first;
    } catch (e) {
      return null;
    }
  }

  FieldSelectData get unselected =>
      firstField == selected ? secondField : firstField;

  FieldSelectData get secondField {
    try {
      return field.fields[1];
    } catch (e) {
      return null;
    }
  }
}
