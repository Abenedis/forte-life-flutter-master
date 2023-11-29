import 'package:flutter/material.dart';
import 'package:forte_life/app/colors.dart';
import 'package:pinput/pin_put/pin_put.dart';

class SMSInputWidget extends StatelessWidget {
  const SMSInputWidget({
    Key key,
    this.onFinished,
    this.isError,
    this.clearError,
  }) : super(key: key);

  final ValueSetter<String> onFinished;
  final bool isError;
  final VoidCallback clearError;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context)
        .textTheme
        .subtitle1
        .copyWith(color: isError ? Colors.white : Colors.black);

    return PinPut(
      fieldsCount: 4,
      fieldsAlignment: MainAxisAlignment.center,
      followingFieldDecoration: isError
          ? _decoration
          : BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(2.0),
            ),
      selectedFieldDecoration: _decoration,
      submittedFieldDecoration: _decoration,
      disabledDecoration: _decoration,
      onTap: _onTap,
      onChanged: _onChanged,
      textStyle: textStyle,
      eachFieldMargin: const EdgeInsets.all(8.0),
      inputDecoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        counterText: '',
        disabledBorder: InputBorder.none,
      ),
      pinAnimationType: PinAnimationType.scale,
    );
  }

  void _onTap() {
    if (isError) {
      clearError();
    }
  }

  void _onChanged(String pin) {
    if (pin.length == 4) {
      onFinished(pin);
    } else if (isError) {
      clearError();
    }
  }

  BoxDecoration get _decoration => isError
      ? BoxDecoration(
          borderRadius: BorderRadius.circular(2.0),
          color: StandardColors.primaryColor,
        )
      : BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(2.0),
        );
}
