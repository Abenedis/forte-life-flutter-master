import 'package:forte_life/core/models/program/zayava_request.dart';
import 'package:forte_life/core/web/program_ws_impl.dart';

class ProgramFormBloc {
  ProgramFormBloc(this._serviceImpl);

  final ProgramWebServiceImpl _serviceImpl;

  Future<dynamic> requestCode(ZayavaRequest request) =>
      _serviceImpl.createOrderRequest(request);
}
