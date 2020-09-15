import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:movie_app/models/apiConfiguration.dart';
import 'package:movie_app/models/series.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/series_details.dart';

class SeriesRepository {
  static final SeriesRepository instance = SeriesRepository._internal();

  factory SeriesRepository() => instance;

  SeriesRepository._internal();

  Future<List<Series>> searchSeries(String name) async {
    name = name.replaceAll(" ", "%20");
    var client = http.Client();
    var series = await client.get(
        'https://api.themoviedb.org/3/search/tv?api_key=${GetIt.I<ApiConfiguration>().apiKey}&language=pt-BR&page=1&query=$name&include_adult=false');

    var seriesJson = jsonDecode(series.body)['results'] as List;
    List<Series> seriesList = seriesJson.map((e) => Series.fromJson(e)).toList();
    return seriesList.where((element) => element != null && element.posterPath != null).toList();
  }

  Future<SeriesDetails> getSeriesDetails(int serieId) async {
    var client = http.Client();
    var response = await client.get(
        'https://api.themoviedb.org/3/tv/$serieId?api_key=${GetIt.I<ApiConfiguration>().apiKey}&language=pt-BR&append_to_response=images,videos');
    var json = jsonDecode(response.body);
    SeriesDetails seriesDetails = SeriesDetails.fromJson(json);
    return seriesDetails;
  }
}
