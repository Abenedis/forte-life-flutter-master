import 'program_model.dart';

class ProgramResponse {
  List<Program> programs;

  ProgramResponse({this.programs});

  ProgramResponse.fromJson(List<dynamic> json) {
    programs = <Program>[];
    programs.addAll(
      json
          ?.map((dynamic v) => Program.fromJson(v as Map<String, dynamic>))
          ?.cast<Program>()
          ?.toList(),
    );
  }

  List<dynamic> toJson() =>
      programs == null ? [] : programs.map((Program v) => v.toJson()).toList();
}
