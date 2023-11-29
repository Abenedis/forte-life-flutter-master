import 'package:flutter/material.dart';
import 'package:forte_life/core/models/program/field_object.dart';
import 'package:forte_life/core/models/program/field_type.dart';
import 'package:forte_life/utils/validator.dart';

class DynamicInputField extends StatelessWidget {
  const DynamicInputField({
    Key key,
    this.field,
    this.controller,
    this.nextFocus,
    this.focus,
  }) : super(key: key);

  final FieldObject field;
  final TextEditingController controller;
  final FocusNode nextFocus;
  final FocusNode focus;

  @override
  Widget build(BuildContext context) {
    if (field == null) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 16.0,
        right: 16.0,
        bottom: 8.0,
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focus ?? FocusNode(),
        textInputAction: TextInputAction.next,
        keyboardType: _defaultKeyboard,
        validator: _defaultValidator,
        maxLength: _maxLength,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(nextFocus),
        decoration: InputDecoration(
          labelText: field.name,
          hintText: field.type == FieldType.phone ? '123456789' : '',
          prefix: _prefix,
          counterText: '',
        ),
      ),
    );
  }

  Widget get _prefix => field.type == FieldType.phone
      ? Text(
          '+380 ',
          style: TextStyle(
            color: Colors.black,
          ),
        )
      : const SizedBox.shrink();

  int get _maxLength => field.type == FieldType.phone ? 9 : null;

  TextInputType get _defaultKeyboard {
    switch (field.type) {
      case FieldType.email:
        return TextInputType.emailAddress;
      case FieldType.phone:
        return TextInputType.phone;
      case FieldType.number:
        return TextInputType.number;
      default:
        return null;
    }
  }

  ValueSetter<String> get _defaultValidator {
    switch (field.type) {
      case FieldType.email:
        return (value) => Validator.emailLength(value, field.lenght);
      case FieldType.phone:
        return (value) => Validator.phoneLength(value, field.lenght);
      case FieldType.number:
        return (value) => Validator.length(value, field.lenght);
      default:
        return (value) => Validator.emptyLength(value, field.lenght);
    }
  }
}
