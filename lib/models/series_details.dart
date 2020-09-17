import 'package:movie_app/models/actor.dart';
import 'package:movie_app/models/image.dart';
import 'package:movie_app/models/video.dart';

class SeriesDetails {
  String originalName;
  String name;
  double popularity;
  int voteCount;
  DateTime firstAirDate;
  String backdropPath;
  String originalLanguage;
  int id;
  double voteAverage;
  String overview;
  String posterPath;
  String homePage;
  bool inProduction;
  DateTime lastAirDate;
  int numberOfEpisodes;
  int numberOfSeasons;
  String status;
  List<Image> backdrops;
  List<Image> posters;
  List<Video> videos;
  List<Actor> actors;

  SeriesDetails(
      this.backdropPath,
      this.firstAirDate,
      this.id,
      this.name,
      this.originalLanguage,
      this.originalName,
      this.overview,
      this.popularity,
      this.posterPath,
      this.voteAverage,
      this.voteCount,
      this.homePage,
      this.inProduction,
      this.lastAirDate,
      this.numberOfEpisodes,
      this.numberOfSeasons,
      this.status,
      this.backdrops,
      this.posters,
      this.videos,
      this.actors);

  factory SeriesDetails.fromJson(dynamic json) {
    return SeriesDetails(
        json['backdrop_path'] as String,
        DateTime.tryParse(json['first_air_date']),
        json['id'] as int,
        json['name'] as String,
        json['original_language'] as String,
        json['original_name'] as String,
        json['overview'] as String,
        json['popularity'].toDouble(),
        json['poster_path'] as String,
        json['vote_average'].toDouble(),
        json['vote_count'] as int,
        json['home_page'] as String,
        json['in_production'] as bool,
        DateTime.tryParse(json['last_air_date']),
        json['number_of_episodes'] as int,
        json['number_of_seasons'] as int,
        json['status'] as String,
        List.from(json['images']['backdrops']).map((e) => Image.fromJson(e)).toList(),
        List.from(json['images']['posters']).map((e) => Image.fromJson(e)).toList(),
        List.from(json['videos']['results']).map((e) => Video.fromJson(e)).toList(),
        List.from(json['credits']['cast']).map((e) => Actor.fromJson(e)).toList());
  }

  List<String> getImagePaths() {
    List<String> paths = List<String>();
    paths..add(this.posterPath)..add(this.backdropPath);
    paths.addAll(this.posters.map((e) => e.filePath).toList());
    paths.addAll(this.backdrops.map((e) => e.filePath));
    return paths.where((element) => element != null).toSet().toList();
  }
}
