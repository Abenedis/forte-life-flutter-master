import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmInfoLabel extends StatelessWidget {
  const ConfirmInfoLabel({
    Key key,
    this.title,
    this.value,
  }) : super(key: key);

  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Wrap(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0).copyWith(left: 0.0),
            child: Text(
              '$title: ',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(value ?? ''),
          ),
        ],
      ),
    );
  }
}
