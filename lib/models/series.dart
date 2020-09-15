import 'package:movie_app/models/mainInfos.dart';

class Series extends MainInfos {
  int id;
  String originalName;
  String title;
  double popularity;
  int voteCount;
  DateTime releaseDate;
  String backdropPath;
  double voteAverage;
  String overview;
  String posterPath;

  Series(this.id, this.backdropPath, this.releaseDate, this.title, this.originalName, this.overview, this.popularity,
      this.posterPath, this.voteAverage, this.voteCount);

  factory Series.fromJson(dynamic json) {
    try {
      return Series(
          json['id'] as int,
          json['backdrop_path'] as String,
          DateTime.tryParse(json['first_air_date']),
          json['name'] as String,
          json['original_name'] as String,
          json['overview'] as String,
          json['popularity'] as double,
          json['poster_path'] as String,
          json['vote_average'].toDouble() as double,
          json['vote_count'] as int);
    } catch (e) {
      return null;
    }
  }
}
