import 'package:forte_life/utils/json_parser.dart';

import 'content_data.dart';
import 'field_object.dart';
import 'photo.dart';

class ProgramDetail {
  int programId;
  String name;
  ContentData contentData;
  FieldsData fields;
  String currency;
  String ofertaUrl;

  ProgramDetail({this.programId, this.name, this.contentData, this.fields});

  ProgramDetail.fromJson(Map<String, dynamic> json) {
    programId = json['program_id'];
    name = json['name'];
    currency = json['currency'];
    ofertaUrl = json['ofertaUrl'];
    contentData = JsonParser.single(
        json['content_data'], (map) => ContentData.fromJson(map));
    fields =
        json['fields'] != null ? new FieldsData.fromJson(json['fields']) : null;
  }
}

class FieldsData {
  Calc calc;
  Map<String, FieldObject> zayava;

  Photo photo;

  FieldsData({
    this.calc,
    this.zayava,
    this.photo,
  });

  FieldsData.fromJson(Map<String, dynamic> json) {
    calc = json['calc'] != null ? new Calc.fromJson(json['calc']) : null;
    zayava = json['zayava'] == null
        ? null
        : (json['zayava'] as Map<String, dynamic>)?.map<String, FieldObject>(
            (key, value) => MapEntry(
              key,
              FieldObject.fromJson(value),
            ),
          );
    photo = json['photo'] != null ? new Photo.fromJson(json['photo']) : null;
  }
}

class Calc {
  FieldObject birthday;
  FieldObject period;
  FieldObject termin;
  FieldObject type;

  Calc({this.birthday, this.period, this.termin, this.type});

  Calc.fromJson(Map<String, dynamic> json) {
    birthday = json['birthday'] != null
        ? new FieldObject.fromJson(json['birthday'])
        : null;
    period = json['period'] != null
        ? new FieldObject.fromJson(json['period'])
        : null;
    termin = json['termin'] != null
        ? new FieldObject.fromJson(json['termin'])
        : null;
    type = json['type'] != null ? new FieldObject.fromJson(json['type']) : null;
  }
}
