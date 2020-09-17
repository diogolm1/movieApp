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

  @override
  void initState() {
    super.initState();
    getPopularSeries();
  }

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: Observer(builder: (_) {
          return Text(seriesSearchStore.title);
        }),
        centerTitle: true,
        actions: [searchBar.getSearchAction(context)]);
  }

  _SeriesSearchPageState() {
    searchBar = new SearchBar(
        inBar: false,
        setState: setState,
        onSubmitted: _searchSeries,
        buildDefaultAppBar: buildAppBar,
        hintText: "Pesquisar");
  }

  _searchSeries(String text) async {
    if (text.isEmpty) {
      seriesSearchStore.setTitle("Pesquise uma série");
      return getPopularSeries();
    }
    seriesSearchStore.setTitle(text);
    seriesSearchStore.toggleSearch();
    var series = await SeriesRepository.instance.searchSeries(text);
    seriesSearchStore.setSeries(series);
  }

  Future<void> getPopularSeries() async {
    seriesSearchStore.toggleSearch();
    var movies = await SeriesRepository.instance.getPopularSeries();
    seriesSearchStore.setSeries(movies);
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
                  child: seriesSearchStore.isSearching
                      ? Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
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
          )
        ],
      ),
    );
  }
}
