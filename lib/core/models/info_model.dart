class Info {
  Info({this.name, this.iconUrl, this.id});

  int id;
  String name;
  String iconUrl;
  String externalUrl;
  bool callback;
  bool isFromCache;
  Info.fromJson(Map<String, dynamic> json) {
    try {
      id = json['page_id'] as int;
      name = json['name'] as String;
      callback = json['callback'] as bool ?? false;
      iconUrl = json['iconUrl'] as String;
      externalUrl = (json['externalUrl'] as String) ?? '';
      isFromCache = json['isFromCache'] as bool ?? false;
    } catch (e) {
      id = -1;
      name = "error";
      iconUrl = null;
      callback = false;
      externalUrl = (json['externalUrl'] as String) ?? '';
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page_id'] = id;
    data['name'] = name;
    data['iconUrl'] = iconUrl;
    return data;
  }
}
