import 'package:flutter/material.dart';

class ContactInputField extends StatelessWidget {
  const ContactInputField({
    Key key,
    this.controller,
    this.prefix,
    this.maxLength,
    this.keyboardType,
    this.validator,
    this.label = '',
    this.hint = '',
    this.minLines = 1,
  }) : super(key: key);

  final TextEditingController controller;
  final Widget prefix;
  final int maxLength;
  final int minLines;
  final TextInputType keyboardType;
  final ValueSetter<String> validator;
  final String label;
  final String hint;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 16.0,
        right: 16.0,
        bottom: 8.0,
      ),
      child: TextFormField(
        controller: controller,
        textInputAction: TextInputAction.next,
        keyboardType: keyboardType,
        validator: validator,
        maxLength: maxLength,
        minLines: minLines,
        maxLines: minLines,
        textAlignVertical: TextAlignVertical.top,
        textAlign: TextAlign.start,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefix: prefix,
          counterText: '',
        ),
      ),
    );
  }
}
