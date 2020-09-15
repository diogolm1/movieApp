import 'package:flutter/material.dart';
import 'package:movie_app/repositories/movieRepository.dart';
import 'package:movie_app/widgets/customCard.dart';

class PopularMoviesPage extends StatefulWidget {
  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  Widget build(BuildContext context) {
    Widget _buildBodyBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.red, Colors.red[200]], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        );

    return Stack(
      children: [
        _buildBodyBack(),
        CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              elevation: 0,
              backgroundColor: Colors.red,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Populares"),
                centerTitle: true,
              ),
            ),
            FutureBuilder(
              future: MovieRepository.instance.getPopularMovies(),
              builder: (_, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    );
                  default:
                    if (snapshot.hasError) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Text("Erro ao carregar dados."),
                        ),
                      );
                    } else {
                      return SliverList(
                        delegate: SliverChildListDelegate(List<CustomCard>.from(snapshot.data.map((e) => CustomCard(
                              cardInfos: e,
                            )))),
                      );
                    }
                }
              },
            )
          ],
        ),
      ],
    );
  }
}
