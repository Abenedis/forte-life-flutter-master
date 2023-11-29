import 'package:flutter/widgets.dart';

class LifeCycleManager extends StatefulWidget {
  const LifeCycleManager({
    Key key,
    this.child,
    this.resumedCallback,
  }) : super(key: key);

  final Widget child;
  final VoidCallback resumedCallback;
  @override
  _LifeCycleManagerState createState() => _LifeCycleManagerState();
}

class _LifeCycleManagerState extends State<LifeCycleManager>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint(state.toString());
    if (state == AppLifecycleState.resumed) {
      widget.resumedCallback();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
