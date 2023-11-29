import 'info_model.dart';

class InfoResponse {
  List<Info> info;

  InfoResponse({this.info});

  InfoResponse.fromJson(List<dynamic> json) {
    info = <Info>[];
    info.addAll(
      json
          ?.map((dynamic v) => Info.fromJson(v as Map<String, dynamic>))
          ?.cast<Info>()
          ?.toList(),
    );
  }

  List<dynamic> toJson() =>
      info == null ? [] : info.map((Info v) => v.toJson()).toList();
}
