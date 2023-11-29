import 'package:flutter/widgets.dart';

import 'loading.dart';

class EasyStreamBuilder<T> extends StatelessWidget {
  const EasyStreamBuilder({
    Key key,
    this.stream,
    this.initialData,
    this.builder,
    this.whenError,
    this.withoudData,
    this.error,
  }) : super(key: key);

  final Stream<T> stream;
  final T initialData;
  final Widget Function(BuildContext, AsyncSnapshot<T>) builder;
  final Widget Function(Object) whenError;
  final WidgetBuilder withoudData;
  final WidgetBuilder error;

  @override
  Widget build(BuildContext context) => StreamBuilder<T>(
        stream: stream,
        initialData: initialData,
        builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
          if (snapshot.hasData) {
            return builder(context, snapshot);
          } else if (snapshot.hasError) {
            debugPrint(snapshot.error.toString());
            return error == null
                ? Center(child: Text(snapshot.error.toString()))
                : error(context);
          }
          return withoudData == null ? const Loading() : withoudData(context);
        },
      );
}
