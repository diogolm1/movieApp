import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:movie_app/stores/page_store.dart';
import 'package:movie_app/views/movies/movie_search_page.dart';
import 'package:movie_app/views/movies/popular_movies_page.dart';
import 'package:movie_app/views/series/series_search_page.dart';
import 'package:movie_app/views/movies/trendingPage.dart';
import 'package:movie_app/widgets/drawer/customDrawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController pageController = PageController();
  final PageStore pageStore = GetIt.I<PageStore>();

  @override
  void initState() {
    super.initState();

    reaction((_) => pageStore.page, (page) {
      Navigator.pop(context);
      pageController.jumpToPage(page);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: CustomDrawer(),
        body: PageView(
          controller: pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [TrendingPage(), PopularMoviesPage(), MovieSearchPage(), SeriesSearchPage()],
        ));
  }
}
