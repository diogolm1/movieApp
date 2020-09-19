import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:movie_app/repositories/seriesRepository.dart';
import 'package:movie_app/stores/series/series_search_store.dart';
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
        title: Text("Séries"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColorDark,
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
      // drawer: CustomDrawer(),
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
                      : (seriesSearchStore.series.length > 0
                          ? ListView.builder(
                              itemCount: seriesSearchStore.series.length,
                              itemBuilder: (context, index) {
                                return CustomCard(
                                  cardInfos: seriesSearchStore.series[index],
                                );
                              })
                          : Container(
                              margin: EdgeInsets.only(top: 15),
                              child: Center(
                                child: Text(
                                  "Nenhum resultado encontrado para \"${seriesSearchStore.title}\"",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ))));
            },
          )
        ],
      ),
    );
  }
}
