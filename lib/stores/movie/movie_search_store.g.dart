// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_search_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MovieSearchStore on _MovieSearchStoreBase, Store {
  final _$titleAtom = Atom(name: '_MovieSearchStoreBase.title');

  @override
  String get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  final _$isSearchingAtom = Atom(name: '_MovieSearchStoreBase.isSearching');

  @override
  bool get isSearching {
    _$isSearchingAtom.reportRead();
    return super.isSearching;
  }

  @override
  set isSearching(bool value) {
    _$isSearchingAtom.reportWrite(value, super.isSearching, () {
      super.isSearching = value;
    });
  }

  final _$_MovieSearchStoreBaseActionController =
      ActionController(name: '_MovieSearchStoreBase');

  @override
  dynamic toggleSearch() {
    final _$actionInfo = _$_MovieSearchStoreBaseActionController.startAction(
        name: '_MovieSearchStoreBase.toggleSearch');
    try {
      return super.toggleSearch();
    } finally {
      _$_MovieSearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setMovies(List<Movie> m) {
    final _$actionInfo = _$_MovieSearchStoreBaseActionController.startAction(
        name: '_MovieSearchStoreBase.setMovies');
    try {
      return super.setMovies(m);
    } finally {
      _$_MovieSearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTitle(String text) {
    final _$actionInfo = _$_MovieSearchStoreBaseActionController.startAction(
        name: '_MovieSearchStoreBase.setTitle');
    try {
      return super.setTitle(text);
    } finally {
      _$_MovieSearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
title: ${title},
isSearching: ${isSearching}
    ''';
  }
}
