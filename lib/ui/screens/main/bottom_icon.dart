import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forte_life/app/colors.dart';
import 'package:forte_life/ui/screens/main/enum_home_screens.dart';
import 'package:forte_life/ui/screens/news/news_bloc.dart';
import 'package:provider/provider.dart';

class BottomIcon extends StatelessWidget {
  final Function _onTap;
  final HomeScreenType _type;
  final bool _isSelected;

  BottomIcon({
    @required type,
    @required isSelected,
    @required onTap,
  })  : this._onTap = onTap,
        this._type = type,
        this._isSelected = isSelected;

  @override
  Widget build(BuildContext context) {
    var color = _isSelected
        ? StandardColors.selectedColor
        : StandardColors.unselectedColor;

    return InkWell(
      onTap: _type == HomeScreenType.NEWS
          ? () {
              _onTap();
              Provider.of<NewsBloc>(context, listen: false).updateCaunter(true);
            }
          : _onTap,
      borderRadius: BorderRadius.all(Radius.circular(45)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _type == HomeScreenType.NEWS
              ? StreamBuilder<int>(
                  stream: Provider.of<NewsBloc>(context).count,
                  initialData: 0,
                  builder: (context, snapshot) {
                    if (snapshot.data <= 0) {
                      return SvgPicture.asset(
                        _type.iconPath,
                        color: color,
                      );
                    }
                    return Badge(
                      badgeContent: Text(
                        snapshot.data.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      child: SvgPicture.asset(
                        _type.iconPath,
                        color: color,
                      ),
                    );
                  })
              : SvgPicture.asset(
                  _type.iconPath,
                  color: color,
                ),
          Text(
            _type.buttonText,
            style: TextStyle(color: color, fontSize: 12),
          )
        ],
      ),
    );
  }
}
