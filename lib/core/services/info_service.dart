import 'package:forte_life/core/models/info_model.dart';

abstract class InfoService {
  Future<List<Info>> getInfo();
}
