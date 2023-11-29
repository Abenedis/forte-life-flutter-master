import 'package:forte_life/core/models/program/zayava_request.dart';
import 'package:forte_life/core/services/program_service.dart';
import 'package:rxdart/rxdart.dart';

class SMSInputBloc {
  final ProgramService _programService;
  final Map<String, dynamic> orderMap;
  final String phone;

  SMSInputBloc(
    this._programService, {
    this.phone = '1357',
    this.orderMap,
  });

  bool isSuccess = false;
  final BehaviorSubject<bool> _isHasErrorSubject = BehaviorSubject<bool>()
    ..add(false);
  Stream<bool> get isHasError => _isHasErrorSubject.stream;

  void clearError() => _isHasErrorSubject.add(false);

  Future<String> validatePin(String pin) async {
    if (!isSuccess) {
      final result = await _programService.validateSMS(phone, pin);
      if (result is Map) {
        isSuccess = true;
        return result['nom_dog'];
      } else {
        isSuccess = false;
        _isHasErrorSubject.add(true);
        return '';
      }
    }
    isSuccess = false;
    return '';
  }

  void sendSMS() {
    isSuccess = false;
    _programService.createOrderRequest(
      ZayavaRequest(fields: orderMap..['phone'] = phone),
    );
  }

  void dispose() {
    _isHasErrorSubject?.close();
  }
}
