import 'package:flutter/material.dart';

class BlinchikLabel extends StatelessWidget {
  const BlinchikLabel({
    Key key,
    this.color,
    this.text,
    this.values,
  }) : super(key: key);
  final Color color;
  final String text;
  final String values;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: color,
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text('$text $valueText'),
          ),
        ),
      ],
    );
  }

  String get valueText => values.isNotEmpty ? '- $values грн' : '';
}
