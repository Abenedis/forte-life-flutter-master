import 'dart:async';

import 'package:forte_life/core/models/program_model.dart';
import 'package:forte_life/core/services/program_service.dart';
import 'package:forte_life/ui/base_bloc.dart';

class ProgramsBloc extends BaseBloc<List<Program>> {
  final ProgramService programService;

  ProgramsBloc(this.programService) {
    _initPrograms();
  }

  Future<void> _initPrograms() async {
    final List<Program> programs = await programService.getPrograms();
    subject.add(programs);
  }
}
