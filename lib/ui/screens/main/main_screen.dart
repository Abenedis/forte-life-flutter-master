import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forte_life/app/colors.dart';
import 'package:forte_life/ui/screens/info/info_screen.dart';
import 'package:forte_life/ui/screens/news/news_bloc.dart';
import 'package:forte_life/ui/screens/news/news_screen.dart';
import 'package:forte_life/ui/screens/programs/programs_screen.dart';
import 'package:forte_life/ui/widget/connectivity_scaffold.dart';
import 'package:forte_life/utils/constants/asset_images.dart';
import 'package:provider/provider.dart';

import 'app_bar.dart';
import 'bottom_menu.dart';
import 'enum_home_screens.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainScreenState();
  static const String defaultFCMTopic = 'ForteLife';
}

class _MainScreenState extends State<MainScreen> {
  HomeScreenType _currentTab = HomeScreenType.PROGRAMS;
  PageController pageController;
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    pageController = PageController(
      keepPage: true,
    );
    pageController.addListener(_pagesListener);
    _intiFCM();
    context.read<NewsBloc>().initNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ConnectivityScaffold(
        isFloating: true,
        backgroundColor: StandardColors.primaryColor,
        appBar: HomeAppBar(title: _currentTab.title),
        extendBody: true,
        extendBodyBehindAppBar: false,
        body: PageView(
          controller: pageController,
          children: <Widget>[
            ProgramsScreen(),
            InfoScreen(),
            NewsScreen(),
          ],
        ),
        floatingActionButton: _FloatingInfoButton(_onScreenSelected),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomMenu(
          onTap: _onScreenSelected,
          current: _currentTab,
        ),
      );

  void _onScreenSelected(HomeScreenType screen) {
    if (_currentTab != screen) {
      pageController.animateToPage(
        screen.index,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _intiFCM() async {
    await messaging.requestPermission();
    messaging.getToken().then(print);
    await messaging.subscribeToTopic(MainScreen.defaultFCMTopic);
  }

  void _pagesListener() {
    if (_currentTab.index != pageController.page.round())
      switch (pageController.page.round()) {
        case 1:
          setState(() {
            _currentTab = HomeScreenType.INFO;
          });
          break;
        case 2:
          setState(() {
            _currentTab = HomeScreenType.NEWS;
          });
          Provider.of<NewsBloc>(context, listen: false).updateCaunter(true);

          break;
        default:
          setState(() {
            _currentTab = HomeScreenType.PROGRAMS;
          });
          break;
      }
  }
}

class _FloatingInfoButton extends StatelessWidget {
  final ValueSetter<HomeScreenType> onTap;

  _FloatingInfoButton(this.onTap);

  @override
  Widget build(BuildContext context) => InkWell(
        borderRadius: BorderRadius.all(Radius.circular(45)),
        onTap: () {
          onTap(HomeScreenType.INFO);
        },
        child: SvgPicture.asset(
          AssetsImages.ic_info,
          height: 80,
          width: 80,
        ),
      );
}
