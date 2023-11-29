import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forte_life/app/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class SMSRepeatWidget extends StatefulWidget {
  const SMSRepeatWidget({
    Key key,
    this.sendSMS,
  }) : super(key: key);
  final VoidCallback sendSMS;
  @override
  _SMSRepeatWidgetState createState() => _SMSRepeatWidgetState();
}

class _SMSRepeatWidgetState extends State<SMSRepeatWidget> {
  int seconds = 0;
  Timer timer;
  void startTimer() {
    setState(() {
      seconds = 60;
    });
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        --seconds;
      });
      if (seconds <= 0) timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (seconds == 0) {
      return InkWell(
        onTap: () {
          startTimer();
          widget.sendSMS();
        },
        child: Text(
          'Надіслати ще раз',
          style: GoogleFonts.roboto(
            fontSize: 20,
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.w500,
            color: StandardColors.primaryColor,
          ),
        ),
      );
    }
    return Text(
      'Відправити повторно через $seconds секунд',
      style: GoogleFonts.roboto(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: StandardColors.primaryColor,
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
