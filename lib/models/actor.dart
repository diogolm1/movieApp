class Actor {
  int id;
  String name;
  String character;
  String creditId;
  String profilePath;

  Actor(this.id, this.character, this.creditId, this.name, this.profilePath);

  factory Actor.fromJson(dynamic json) {
    try {
      return Actor(json['id'] as int, json['character'] as String, json['credit_id'] as String, json['name'] as String,
          json['profile_path'] as String);
    } catch (e) {
      return null;
    }
  }
}
