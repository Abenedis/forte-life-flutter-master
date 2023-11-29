import 'package:forte_life/core/models/program/field_type.dart';
import 'package:forte_life/utils/json_parser.dart';

import 'filed_select_data.dart';

class FieldObject {
  final FieldType type;
  final String name;
  final int min;
  final int max;
  final List<FieldSelectData> fields;
  final List<int> lenght;
  const FieldObject({
    this.type,
    this.name,
    this.min,
    this.max,
    this.fields,
    this.lenght = const <int>[],
  });

  FieldObject.fromJson(Map<String, dynamic> json)
      : type = FieldTypeConverter.fromString(json['type']),
        name = json['name'],
        min = json['min'],
        max = json['max'],
        lenght = List<int>.from(json['lenght'] ?? []),
        fields = JsonParser.list(
          json['fields'],
          (map) => FieldSelectData.fromJson(map),
        );
}
