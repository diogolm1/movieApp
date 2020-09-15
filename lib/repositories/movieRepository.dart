import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:movie_app/models/apiConfiguration.dart';
import 'package:movie_app/models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/movie_details.dart';

class MovieRepository {
  static final MovieRepository instance = MovieRepository._internal();

  factory MovieRepository() => instance;

  MovieRepository._internal();

  Future<List<Movie>> getTrendingMovies() async {
    var client = http.Client();
    var apiConfig = GetIt.I<ApiConfiguration>();
    var movies =
        await client.get('https://api.themoviedb.org/3/trending/movie/day?api_key=${apiConfig.apiKey}&language=pt-BR');

    var moviesJson = jsonDecode(movies.body)['results'] as List;
    List<Movie> moviesList = moviesJson.map((e) => Movie.fromJson(e)).toList();
    return moviesList;
  }

  Future<MovieDetails> getMovieDetails(int movieId) async {
    var client = http.Client();
    var response = await client.get(
        'https://api.themoviedb.org/3/movie/${movieId}?api_key=${GetIt.I<ApiConfiguration>().apiKey}&language=pt-BR&region=BR&append_to_response=images,videos&include_image_language=pt,null');
    var json = jsonDecode(response.body);
    MovieDetails movieDetails = MovieDetails.fromJson(json);
    return movieDetails;
  }

  Future<List<Movie>> getPopularMovies() async {
    var client = http.Client();
    var movies = await client.get(
        'https://api.themoviedb.org/3/movie/popular?api_key=${GetIt.I<ApiConfiguration>().apiKey}&language=pt-BR&page=1&region=BR');

    var moviesJson = jsonDecode(movies.body)['results'] as List;
    List<Movie> moviesList = moviesJson.map((e) => Movie.fromJson(e)).toList();
    return moviesList;
  }

  Future<List<Movie>> searchMovie(String name) async {
    name = name.replaceAll(" ", "%20");
    var client = http.Client();
    var movies = await client.get(
        'https://api.themoviedb.org/3/search/movie?api_key=${GetIt.I<ApiConfiguration>().apiKey}&language=pt-BR&query=$name&page=1&include_adult=false&region=BR');

    var moviesJson = jsonDecode(movies.body)['results'] as List;
    List<Movie> moviesList = moviesJson.map((e) => Movie.fromJson(e)).toList();
    return moviesList.where((element) => element != null && element.posterPath != null).toList();
  }
}
