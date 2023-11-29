import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import 'life_cycle_widget.dart';

class ConnectivityScaffold extends StatefulWidget {
  const ConnectivityScaffold({
    Key key,
    this.appBar,
    this.body,
    this.resizeToAvoidBottomInset,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.isFloating = false,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
  }) : super(key: key);
  final PreferredSizeWidget appBar;
  final Widget body;
  final bool resizeToAvoidBottomInset;
  final Widget bottomNavigationBar;
  final Widget floatingActionButton;
  final Color backgroundColor;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final bool isFloating;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  @override
  _ConnectivityScaffoldState createState() => _ConnectivityScaffoldState();
}

class _ConnectivityScaffoldState extends State<ConnectivityScaffold> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  Timer _checkTimer;
  ConnectivityResult lastResult;
  @override
  void initState() {
    // lastResult = ConnectivityResult.wifi;
    _scaffoldKey = GlobalKey<ScaffoldState>();
    connectivity.checkConnectivity().then(_showConnectivityStatus);
    _checkTimerTask();
    super.initState();
  }

  Future<void> _checkTimerTask() async {
    await connectivity.checkConnectivity().then(_showConnectivityStatus);
    _checkTimer?.cancel();
    _checkTimer = Timer(
      Duration(seconds: 5),
      _checkTimerTask,
    );
  }

  @override
  void dispose() {
    _checkTimer?.cancel();
    super.dispose();
  }

  void _showConnectivityStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.none &&
        lastResult != ConnectivityResult.none) {
      lastResult = result;
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Немає підключення до Інтернету'),
          backgroundColor: Colors.redAccent,
          duration: const Duration(days: 1),
          behavior: widget.isFloating
              ? SnackBarBehavior.floating
              : SnackBarBehavior.fixed,
        ),
      );
    } else if (result != ConnectivityResult.none) {
      lastResult = result;
      _scaffoldKey.currentState.removeCurrentSnackBar();
    }
  }

  @override
  void didUpdateWidget(covariant ConnectivityScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    connectivity.checkConnectivity().then(_showConnectivityStatus);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    connectivity.checkConnectivity().then(_showConnectivityStatus);
  }

  @override
  Widget build(BuildContext context) {
    return LifeCycleManager(
      resumedCallback: _checkTimerTask,
      child: Scaffold(
        extendBody: widget.extendBody,
        extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
        key: _scaffoldKey,
        backgroundColor: widget.backgroundColor,
        appBar: widget.appBar,
        body: widget.body,
        bottomNavigationBar: widget.bottomNavigationBar,
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        floatingActionButton: widget.floatingActionButton,
        floatingActionButtonLocation: widget.floatingActionButtonLocation,
      ),
    );
  }
}
