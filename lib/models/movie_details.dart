import 'package:movie_app/models/genre.dart';
import 'package:movie_app/models/image.dart';
import 'package:movie_app/models/video.dart';

class MovieDetails {
  int id;
  String title;
  String backdropPath;
  String overview;
  String posterPath;
  DateTime releaseDate;
  double voteAverage;
  int budget;
  int revenue;
  String status;
  int voteCount;
  double popularity;
  List<Genre> genres;
  List<Image> backdrops;
  List<Image> posters;
  List<Video> videos;

  MovieDetails(
      this.id,
      this.title,
      this.backdropPath,
      this.overview,
      this.posterPath,
      this.releaseDate,
      this.voteAverage,
      this.budget,
      this.genres,
      this.popularity,
      this.revenue,
      this.status,
      this.voteCount,
      this.backdrops,
      this.posters,
      this.videos);

  factory MovieDetails.fromJson(dynamic json) {
    return MovieDetails(
        json['id'] as int,
        json['title'] as String,
        json['backdrop_path'] as String,
        json['overview'] as String,
        json['poster_path'] as String,
        DateTime.parse(json['release_date']),
        json['vote_average'] as double,
        json['budget'] as int,
        List.from(json['genres']).map((e) => Genre.fromJson(e)).toList(),
        json['popularity'] as double,
        json['revenue'] as int,
        json['status'] as String,
        json['voteCount'] as int,
        List.from(json['images']['backdrops']).map((e) => Image.fromJson(e)).toList(),
        List.from(json['images']['posters']).map((e) => Image.fromJson(e)).toList(),
        List.from(json['videos']['results']).map((e) => Video.fromJson(e)).toList());
  }

  List<String> getImagePaths() {
    List<String> paths = List<String>();
    paths..add(this.posterPath)..add(this.backdropPath);
    paths.addAll(this.posters.map((e) => e.filePath).toList());
    paths.addAll(this.backdrops.map((e) => e.filePath));
    return paths.where((element) => element != null).toSet().toList();
  }
}
