class ZayavaRequest {
  final String birthday;
  final Map<String, dynamic> fields;

  const ZayavaRequest({
    this.birthday,
    this.fields,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (birthday != null) map['birthday'] = birthday;
    map.addAll(fields);
    return map..removeWhere((key, value) => value == null);
  }
}
