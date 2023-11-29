import 'package:flutter/material.dart';
import 'package:forte_life/app/colors.dart';
import 'package:forte_life/ui/screens/main/enum_home_screens.dart';

import 'bottom_icon.dart';

class BottomMenu extends BottomAppBar {
  BottomMenu({ValueSetter<HomeScreenType> onTap, HomeScreenType current})
      : super(
          color: StandardColors.accentColor,
          shape: CircularNotchedRectangle(),
          child: Container(
            height: 55,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Padding(
                padding: EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    BottomIcon(
                      type: HomeScreenType.PROGRAMS,
                      isSelected: HomeScreenType.PROGRAMS == current,
                      onTap: () {
                        onTap(HomeScreenType.PROGRAMS);
                      },
                    ),
                    Spacer(),
                    BottomIcon(
                      type: HomeScreenType.NEWS,
                      isSelected: HomeScreenType.NEWS == current,
                      onTap: () {
                        onTap(HomeScreenType.NEWS);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
}
