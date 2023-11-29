import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:forte_life/app/colors.dart';
import 'package:forte_life/ui/screens/profile/profile_cards_info.dart';
import 'package:forte_life/ui/screens/profile/profile_list_item.dart';
import 'package:forte_life/ui/widget/connectivity_scaffold.dart';
import 'package:forte_life/utils/constants/strings.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  PageController controller;
  @override
  void initState() {
    controller = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ConnectivityScaffold(
        backgroundColor: StandardColors.primaryColor,
        appBar: AppBar(
          title: MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: Text(Strings.enter_to_cabinets),
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              height: 475,
              child: PageView.builder(
                controller: controller,
                itemCount: ProfileCardInfo.info.length,
                itemBuilder: (_, i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 16.0,
                    ),
                    child: ProfileListItem(
                      profileCard: ProfileCardInfo.info[i],
                      isSmallPadding: i == ProfileCardInfo.info.length - 1,
                    ),
                  );
                },
              ),
            ),
            PageIndicator(
              layout: PageIndicatorLayout.WARM,
              size: 10.0,
              controller: controller,
              space: 5.0,
              color: Colors.white,
              activeColor: Colors.black,
              count: 3,
            ),
          ],
        ),
      );
}
