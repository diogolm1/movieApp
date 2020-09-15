import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:movie_app/repositories/seriesRepository.dart';
import 'package:movie_app/stores/series/series_search_store.dart';
import 'package:movie_app/widgets/drawer/customDrawer.dart';
import 'package:movie_app/widgets/customCard.dart';

class SeriesSearchPage extends StatefulWidget {
  @override
  _SeriesSearchPageState createState() => _SeriesSearchPageState();
}

class _SeriesSearchPageState extends State<SeriesSearchPage> {
  SearchBar searchBar;
  SeriesSearchStore seriesSearchStore = new SeriesSearchStore();

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text('Pesquise uma série'), centerTitle: true, actions: [searchBar.getSearchAction(context)]);
  }

  _SeriesSearchPageState() {
    searchBar =
        new SearchBar(inBar: false, setState: setState, onSubmitted: _searchSeries, buildDefaultAppBar: buildAppBar);
  }

  _searchSeries(String text) async {
    var series = await SeriesRepository.instance.searchSeries(text);
    seriesSearchStore.toggleSearch();
    seriesSearchStore.setSeries(series);
    seriesSearchStore.toggleSearch();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: searchBar.build(context),
      drawer: CustomDrawer(),
      body: Observer(
        builder: (_) {
          return Container(
              child: seriesSearchStore.isSearching
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    )
                  : ListView.builder(
                      itemCount: seriesSearchStore.series.length,
                      itemBuilder: (context, index) {
                        return CustomCard(
                          cardInfos: seriesSearchStore.series[index],
                        );
                      }));
        },
      ),
    );
  }
}
