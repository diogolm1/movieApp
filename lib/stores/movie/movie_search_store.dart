import 'package:mobx/mobx.dart';
import 'package:movie_app/models/movie.dart';
part 'movie_search_store.g.dart';

class MovieSearchStore = _MovieSearchStoreBase with _$MovieSearchStore;

abstract class _MovieSearchStoreBase with Store {
  ObservableList<Movie> movies = ObservableList();

  @observable
  String title = "Pesquise um filme";

  @observable
  bool isSearching = false;

  @action
  toggleSearch() => isSearching = !isSearching;

  @action
  setMovies(List<Movie> m) {
    movies.clear();
    movies.addAll(m);
    isSearching = false;
  }

  @action
  setTitle(String text) {
    title = text;
  }
}
