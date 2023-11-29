import 'package:flutter/material.dart';
import 'package:forte_life/app/colors.dart';

class Loading extends StatelessWidget {
  const Loading({Key key, this.color = StandardColors.accentColor})
      : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) => Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(this.color),
        ),
      );
}
