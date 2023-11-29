class Program {
  Program({
    this.id,
    this.name,
    this.iconUrl,
    this.isBlinchiki,
    this.isPromo,
  });

  String name;
  String iconUrl;
  int id;
  bool isPromo;
  bool isBlinchiki;

  Program.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String;
    iconUrl = json['iconUrl'] as String;
    id = json['program_id'] as int;
    isPromo = json['isPromo'] as bool;
    isBlinchiki = (json['isBlinchiki'] as bool) ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['iconUrl'] = iconUrl;
    data['program_id'] = id;
    return data;
  }
}
