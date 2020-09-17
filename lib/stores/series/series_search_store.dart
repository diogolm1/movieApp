import 'package:mobx/mobx.dart';
import 'package:movie_app/models/series.dart';
part 'series_search_store.g.dart';

class SeriesSearchStore = _SeriesSearchStoreBase with _$SeriesSearchStore;

abstract class _SeriesSearchStoreBase with Store {
  ObservableList<Series> series = ObservableList();

  @observable
  String title = "Pesquise uma série";

  @observable
  bool isSearching = false;

  @action
  toggleSearch() => isSearching = !isSearching;

  @action
  setSeries(List<Series> m) {
    series.clear();
    series.addAll(m);
    isSearching = false;
  }

  @action
  setTitle(String text) {
    title = text;
  }
}
