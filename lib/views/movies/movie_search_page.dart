import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:movie_app/repositories/movieRepository.dart';
import 'package:movie_app/stores/movie/movie_search_store.dart';
import 'package:movie_app/widgets/drawer/customDrawer.dart';
import 'package:movie_app/widgets/customCard.dart';

class MovieSearchPage extends StatefulWidget {
  @override
  _MovieSearchPageState createState() => _MovieSearchPageState();
}

class _MovieSearchPageState extends State<MovieSearchPage> {
  SearchBar searchBar;
  MovieSearchStore movieSearchStore = new MovieSearchStore();

  @override
  void initState() {
    super.initState();
    getPopularMovies();
  }

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: Observer(builder: (_) => Text(movieSearchStore.title)),
        centerTitle: true,
        actions: [searchBar.getSearchAction(context)]);
  }

  _MovieSearchPageState() {
    searchBar =
        new SearchBar(inBar: false, setState: setState, onSubmitted: _searchMovie, buildDefaultAppBar: buildAppBar);
  }

  _searchMovie(String text) async {
    if (text.isEmpty) {
      movieSearchStore.setTitle("Pesquise um filme");
      return getPopularMovies();
    }
    movieSearchStore.setTitle(text);
    movieSearchStore.toggleSearch();
    var movies = await MovieRepository.instance.searchMovie(text);
    movieSearchStore.setMovies(movies);
  }

  Future<void> getPopularMovies() async {
    movieSearchStore.toggleSearch();
    var movies = await MovieRepository.instance.getPopularMovies();
    movieSearchStore.setMovies(movies);
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildBodyBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Theme.of(context).primaryColorDark, Theme.of(context).primaryColorLight],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
        );
    return new Scaffold(
      appBar: searchBar.build(context),
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          _buildBodyBack(),
          Observer(
            builder: (_) {
              return Container(
                  child: movieSearchStore.isSearching
                      ? Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : ListView.builder(
                          itemCount: movieSearchStore.movies.length,
                          itemBuilder: (context, index) {
                            return CustomCard(
                              cardInfos: movieSearchStore.movies[index],
                            );
                          }));
            },
          )
        ],
      ),
    );
  }
}
