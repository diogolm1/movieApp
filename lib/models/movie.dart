import 'package:movie_app/models/mainInfos.dart';

class Movie extends MainInfos {
  int id;
  String title;
  String backdropPath;
  String overview;
  String posterPath;
  DateTime releaseDate;
  double voteAverage;
  double popularity;

  Movie(
      {this.id,
      this.title,
      this.backdropPath,
      this.overview,
      this.posterPath,
      this.releaseDate,
      this.voteAverage,
      this.popularity});

  factory Movie.fromJson(dynamic json) {
    try {
      return Movie(
          id: json['id'] as int,
          title: json['title'] as String,
          backdropPath: json['backdrop_path'] as String,
          overview: json['overview'] as String,
          posterPath: json['poster_path'] as String,
          releaseDate: DateTime.parse(json['release_date']),
          voteAverage: json['vote_average'].toDouble(),
          popularity: json['popularity'].toDouble());
    } catch (e) {
      return null;
    }
  }
}
