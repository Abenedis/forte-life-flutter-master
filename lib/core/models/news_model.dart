class News {
  final int pageId;
  final String name;
  final String shortDescription;
  final int timestamp;
  final String iconUrl;
  final bool isFromCache;

  const News({
    this.pageId,
    this.name,
    this.shortDescription,
    this.timestamp,
    this.iconUrl,
    this.isFromCache,
  });

  News.fromJson(Map<String, dynamic> json)
      : pageId = json['page_id'],
        name = json['name'],
        shortDescription = json['short_description'],
        timestamp = json['timestamp'],
        iconUrl = json['iconUrl'] ?? '',
        isFromCache = json['isFromCache'] as bool ?? false;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page_id'] = this.pageId;
    data['name'] = this.name;
    data['short_description'] = this.shortDescription;
    data['timestamp'] = this.timestamp;
    data['iconUrl'] = this.iconUrl;
    return data;
  }
}
