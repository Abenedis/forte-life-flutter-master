import 'package:forte_life/core/models/calculate_program_entity.dart';
import 'package:forte_life/core/models/program/popup_program_response.dart';
import 'package:forte_life/core/models/program/program_detail.dart';
import 'package:forte_life/core/models/program/zayava_request.dart';
import 'package:forte_life/core/models/program_model.dart';

abstract class ProgramService {
  Future<List<Program>> getPrograms();
  Future<ProgramDetail> getProgramById(int id);
  Future<PopupProgramResponse> calculateProgram(CalculateProgramEntity payload);
  Future<dynamic> createOrderRequest(ZayavaRequest payload);
  Future<dynamic> validateSMS(String phone, String code);
}
