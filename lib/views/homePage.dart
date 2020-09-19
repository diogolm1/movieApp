import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/stores/page_store.dart';
import 'package:movie_app/views/movies/movie_search_page.dart';
import 'package:movie_app/views/series/series_search_page.dart';
import 'package:movie_app/views/movies/trendingPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController pageController = PageController();
  final PageStore pageStore = GetIt.I<PageStore>();

  List<Widget> _widgetOptions = <Widget>[MovieSearchPage(), TrendingPage(), SeriesSearchPage()];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColorDark,
      child: SafeArea(
        child: Observer(
          builder: (_) => Scaffold(
            body: Center(
              child: _widgetOptions.elementAt(pageStore.page),
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Theme.of(context).primaryColorDark,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.movie,
                  ),
                  title: Text(
                    'Filmes',
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.trending_up,
                  ),
                  title: Text(
                    'Tendências',
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.live_tv,
                  ),
                  title: Text(
                    'Séries',
                  ),
                )
              ],
              currentIndex: pageStore.page,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.black,
              onTap: (int index) => pageStore.setPage(index),
            ),
          ),
        ),
      ),
    );
  }
}
