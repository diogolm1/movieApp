class Video {
  String id;
  String iso6391;
  String iso31661;
  String key;
  String name;
  String site;
  String type;

  Video(this.id, this.iso31661, this.iso6391, this.key, this.name, this.site, this.type);

  factory Video.fromJson(dynamic json) {
    return Video(json['id'] as String, json['iso_639_1'] as String, json['iso_3166_1'] as String, json['key'] as String,
        json['name'] as String, json['site'] as String, json['type'] as String);
  }
}
