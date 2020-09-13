class Genre {
  int id;
  String name;

  Genre(this.id, this.name);

  factory Genre.fromJson(dynamic json) {
    return Genre(json['id'] as int, json['name'] as String);
  }
}
