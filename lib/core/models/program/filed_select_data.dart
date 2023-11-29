import 'package:forte_life/core/models/program/range_num.dart';
import 'package:forte_life/utils/json_parser.dart';

class FieldSelectData {
  final String name;
  final int value;
  final RangeNum pay;

  FieldSelectData({
    this.name,
    this.value,
    this.pay,
  });

  FieldSelectData.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        value = json['value'],
        pay = JsonParser.single(
          json['pay'],
          (map) => RangeNum.fromJson(map),
        );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }

  bool get isHasPay => pay != null && pay.isHasValue;
}
