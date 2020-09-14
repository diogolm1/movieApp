class Movie {
  int id;
  String title;
  String backdropPath;
  String overview;
  String posterPath;
  DateTime releaseDate;
  double voteAverage;

  Movie(this.id, this.title, this.backdropPath, this.overview, this.posterPath, this.releaseDate, this.voteAverage);

  factory Movie.fromJson(dynamic json) {
    try {
      return Movie(
          json['id'] as int,
          json['title'] as String,
          json['backdrop_path'] as String,
          json['overview'] as String,
          json['poster_path'] as String,
          DateTime.parse(json['release_date']),
          json['vote_average'].toDouble() as double);
    } catch (e) {
      return null;
    }
  }
}
