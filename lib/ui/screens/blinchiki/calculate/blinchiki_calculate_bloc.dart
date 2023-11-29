import 'package:forte_life/core/models/blinchiki_calculation_result.dart';
import 'package:forte_life/core/services/blinchiki_service.dart';
import 'package:rxdart/subjects.dart';

import '../../../base_bloc.dart';

class BlinchikiCalculateBloc extends BaseBloc<BlinckikiCalculationResult> {
  final BlinchikiService _service;

  int lastCalculatedSum;
  BlinchikiCalculateBloc(this._service);

  final BehaviorSubject<int> _sumSubject = BehaviorSubject<int>()..add(500000);
  Stream<int> get sum => _sumSubject.stream;

  void updateSum(int value) => _sumSubject.add(value);
  Future<void> calculate() async {
    final res = await _service.calculate(_sumSubject.value);
    lastCalculatedSum = _sumSubject.value;
    subject.add(res);
  }
}
