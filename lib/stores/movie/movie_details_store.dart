import 'package:mobx/mobx.dart';
part 'movie_details_store.g.dart';

class MovieDetailsStore = _MovieDetailsStoreBase with _$MovieDetailsStore;

abstract class _MovieDetailsStoreBase with Store {
  @observable
  int currentVideo = 0;

  @action
  void setCurrentVideo(int value) => currentVideo = value;
}
