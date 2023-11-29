import 'package:forte_life/core/services/blinchiki_service.dart';
import 'package:rxdart/rxdart.dart';

class BlinchikiConfirmBloc {
  final BlinchikiService _blinchikiService;

  BlinchikiConfirmBloc(
    this._blinchikiService,
  );

  bool isSuccess = false;
  final BehaviorSubject<bool> _isHasErrorSubject = BehaviorSubject<bool>()
    ..add(false);
  Stream<bool> get isHasError => _isHasErrorSubject.stream;

  void clearError() => _isHasErrorSubject.add(false);

  Future<bool> validatePin(String pin) async {
    if (!isSuccess) {
      final result = await _blinchikiService.validateCode(pin);
      if (result ?? false) {
        isSuccess = true;
        return result;
      } else {
        isSuccess = false;
        _isHasErrorSubject.add(true);
        return false;
      }
    }
    isSuccess = false;
    return false;
  }

  void dispose() {
    _isHasErrorSubject?.close();
  }
}
