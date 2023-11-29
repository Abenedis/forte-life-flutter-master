abstract class JsonParser {
  static List<T> list<T>(
          dynamic json, T Function(Map<String, dynamic>) fromJson) =>
      (json as List<dynamic>)
          ?.map((dynamic v) => fromJson(v as Map<String, dynamic>))
          ?.cast<T>()
          ?.toList() ??
      <T>[];
  static T single<T>(dynamic json, T Function(Map<String, dynamic>) fromJson) =>
      json != null ? fromJson(json as Map<String, dynamic>) : null;
}
