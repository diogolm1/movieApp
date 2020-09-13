import 'package:flutter/material.dart';
import 'package:movie_app/repositories/movieRepository.dart';
import 'package:movie_app/widgets/movieCard.dart';

class TrendingPage extends StatelessWidget {
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
                title: const Text("Tendências"),
                centerTitle: true,
              ),
            ),
            FutureBuilder(
              future: MovieRepository.instance.getTrendingMovies(),
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
                        delegate: SliverChildListDelegate(List<MovieCard>.from(snapshot.data.map((e) => MovieCard(
                              movie: e,
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
