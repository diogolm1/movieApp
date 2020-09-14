// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MovieDetailsStore on _MovieDetailsStoreBase, Store {
  final _$currentVideoAtom = Atom(name: '_MovieDetailsStoreBase.currentVideo');

  @override
  int get currentVideo {
    _$currentVideoAtom.reportRead();
    return super.currentVideo;
  }

  @override
  set currentVideo(int value) {
    _$currentVideoAtom.reportWrite(value, super.currentVideo, () {
      super.currentVideo = value;
    });
  }

  final _$_MovieDetailsStoreBaseActionController =
      ActionController(name: '_MovieDetailsStoreBase');

  @override
  void setCurrentVideo(int value) {
    final _$actionInfo = _$_MovieDetailsStoreBaseActionController.startAction(
        name: '_MovieDetailsStoreBase.setCurrentVideo');
    try {
      return super.setCurrentVideo(value);
    } finally {
      _$_MovieDetailsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentVideo: ${currentVideo}
    ''';
  }
}
