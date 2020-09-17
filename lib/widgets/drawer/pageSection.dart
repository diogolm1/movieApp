import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/stores/page_store.dart';
import 'package:movie_app/widgets/drawer/pageTile.dart';

class PageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PageStore pageStore = GetIt.I<PageStore>();

    return Column(
      children: [
        PageTile(
            label: "Tendências",
            iconData: Icons.trending_up,
            onTap: () {
              pageStore.setPage(0);
            },
            highlighted: pageStore.page == 0),
        PageTile(
            label: "Filmes",
            iconData: Icons.movie,
            onTap: () {
              pageStore.setPage(1);
            },
            highlighted: pageStore.page == 1),
        PageTile(
            label: "Séries",
            iconData: Icons.live_tv,
            onTap: () {
              pageStore.setPage(2);
            },
            highlighted: pageStore.page == 2)
      ],
    );
  }
}
