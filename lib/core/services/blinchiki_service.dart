import 'package:forte_life/core/models/blinchiki_calculation_result.dart';

abstract class BlinchikiService {
  Future<bool> validateCode(String code);
  Future<BlinckikiCalculationResult> calculate(int sum);
}
