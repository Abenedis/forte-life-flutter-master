import 'package:flutter/material.dart';
import 'package:forte_life/core/models/program/field_object.dart';
import 'package:forte_life/core/models/program/field_type.dart';
import 'package:forte_life/ui/screens/program_form/widget/dynamic_input_field.dart';
import 'package:forte_life/ui/widget/date/date_widget.dart';

class GeneralFieldWidget extends StatelessWidget {
  const GeneralFieldWidget({
    Key key,
    this.field,
    this.controller,
  }) : super(key: key);

  final FieldObject field;
  final dynamic controller;

  @override
  Widget build(BuildContext context) {
    switch (field.type) {
      case FieldType.input:
      case FieldType.email:
      case FieldType.phone:
      case FieldType.textArea:
      case FieldType.number:
        return DynamicInputField(
          field: field,
          controller: controller,
        );
      case FieldType.delimetr:
        return Divider();
      case FieldType.title:
        return Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            left: 16.0,
            right: 16.0,
            bottom: 8.0,
          ),
          child: Text(
            field.name,
          ),
        );
      case FieldType.date:
        return Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            left: 16.0,
            right: 16.0,
            bottom: 8.0,
          ),
          child: DateWidget(
            controller: controller,
            title: field.name,
          ),
        );
      default:
        return Text('UNKNOWN PROPERTY ${field.name}');
    }
  }
}
