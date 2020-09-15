// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series_search_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SeriesSearchStore on _SeriesSearchStoreBase, Store {
  final _$isSearchingAtom = Atom(name: '_SeriesSearchStoreBase.isSearching');

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

  final _$_SeriesSearchStoreBaseActionController =
      ActionController(name: '_SeriesSearchStoreBase');

  @override
  dynamic toggleSearch() {
    final _$actionInfo = _$_SeriesSearchStoreBaseActionController.startAction(
        name: '_SeriesSearchStoreBase.toggleSearch');
    try {
      return super.toggleSearch();
    } finally {
      _$_SeriesSearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSeries(List<Series> m) {
    final _$actionInfo = _$_SeriesSearchStoreBaseActionController.startAction(
        name: '_SeriesSearchStoreBase.setSeries');
    try {
      return super.setSeries(m);
    } finally {
      _$_SeriesSearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isSearching: ${isSearching}
    ''';
  }
}
