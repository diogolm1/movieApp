import 'package:mobx/mobx.dart';
import 'package:movie_app/models/movie.dart';
part 'movie_search_store.g.dart';

class MovieSearchStore = _MovieSearchStoreBase with _$MovieSearchStore;

abstract class _MovieSearchStoreBase with Store {
  ObservableList<Movie> movies = ObservableList();

  @observable
  bool isSearching = false;

  @action
  toggleSearch() => isSearching = !isSearching;

  @action
  setMovies(List<Movie> m) {
    this.movies.clear();
    this.movies.addAll(m);
  }
}
