import 'package:rxdart/rxdart.dart';

abstract class BaseBloc<T> {
  BehaviorSubject<T> subject = BehaviorSubject();

  void dispose() {
    subject.close();
  }
}
