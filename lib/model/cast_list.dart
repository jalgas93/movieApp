class CastList {
  final List<Cast> cast;

  CastList({this.cast});
}

class Cast {
  String name;

  String profilePath;
  String character;

  Cast({this.name, this.character, this.profilePath});

  factory Cast.fromJson(dynamic json) {
    if (json == null) {
      return Cast();
    }
    return Cast(
        name: json['name'],
        profilePath: json['profile_path'],
        character: json['character']);
  }
}
