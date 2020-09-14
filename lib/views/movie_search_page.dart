import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:mobx/mobx.dart';
import 'package:movie_app/repositories/movieRepository.dart';
import 'package:movie_app/stores/movie_search_store.dart';
import 'package:movie_app/widgets/movieCard.dart';

class MovieSearchPage extends StatefulWidget {
  @override
  _MovieSearchPageState createState() => _MovieSearchPageState();
}

class _MovieSearchPageState extends State<MovieSearchPage> {
  SearchBar searchBar;
  MovieSearchStore movieSearchStore = new MovieSearchStore();

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text('Pesquise um filme'), centerTitle: true, actions: [searchBar.getSearchAction(context)]);
  }

  _MovieSearchPageState() {
    searchBar =
        new SearchBar(inBar: false, setState: setState, onSubmitted: _searchMovie, buildDefaultAppBar: buildAppBar);
  }

  _searchMovie(String text) async {
    var movies = await MovieRepository.instance.searchMovie(text);
    movieSearchStore.toggleSearch();
    movieSearchStore.setMovies(movies);
    movieSearchStore.toggleSearch();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: searchBar.build(context),
      body: Observer(
        builder: (_) {
          return Container(
              child: movieSearchStore.isSearching
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    )
                  : ListView.builder(
                      itemCount: movieSearchStore.movies.length,
                      itemBuilder: (context, index) {
                        return MovieCard(
                          movie: movieSearchStore.movies[index],
                        );
                      }));
        },
      ),
    );
  }
}
