import 'package:forte_life/utils/json_parser.dart';

import 'label.dart';

class ContentData {
  String banner;
  List<Label> icons;
  String text;
  String url;

  ContentData({this.banner, this.icons, this.text, this.url});

  ContentData.fromJson(Map<String, dynamic> json) {
    banner = json['banner'];
    icons = JsonParser.list(json['icons'], (map) => Label.fromJson(map));
    text = json['text'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['banner'] = this.banner;
    if (this.icons != null) {
      data['icons'] = this.icons.map((v) => v.toJson()).toList();
    }
    data['text'] = this.text;
    data['url'] = this.url;
    return data;
  }
}
