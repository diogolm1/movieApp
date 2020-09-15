import 'package:mobx/mobx.dart';
import 'package:movie_app/models/series.dart';
part 'series_search_store.g.dart';

class SeriesSearchStore = _SeriesSearchStoreBase with _$SeriesSearchStore;

abstract class _SeriesSearchStoreBase with Store {
  ObservableList<Series> series = ObservableList();

  @observable
  bool isSearching = false;

  @action
  toggleSearch() => isSearching = !isSearching;

  @action
  setSeries(List<Series> m) {
    this.series.clear();
    this.series.addAll(m);
  }
}
