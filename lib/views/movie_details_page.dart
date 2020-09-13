import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/helpers/format_helper.dart';
import 'package:movie_app/models/apiConfiguration.dart';
import 'package:movie_app/models/movie_details.dart';
import 'package:movie_app/repositories/movieRepository.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailsPage extends StatefulWidget {
  final int movieId;
  final String title;

  const MovieDetailsPage({this.movieId, this.title});

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetailsPage> {
  int _currentImage = 0;

  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'iLnmTe5Q2Qw',
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _controller,
          ),
          builder: (context, player) {
            return Scaffold(
                appBar: AppBar(
                  title: Text(widget.title),
                  centerTitle: true,
                ),
                body: FutureBuilder(
                  future: MovieRepository.instance.getMovieDetails(widget.movieId),
                  builder: (_, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        );
                      default:
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Erro ao carregar dados."),
                          );
                        } else {
                          MovieDetails movieDetails = snapshot.data;
                          List<String> imagePaths = movieDetails.getImagePaths();
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    movieDetails.title,
                                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
                                  ),
                                ),
                                CarouselSlider(
                                  options: CarouselOptions(
                                      viewportFraction: 1.0,
                                      enlargeCenterPage: false,
                                      enableInfiniteScroll: true,
                                      autoPlay: true,
                                      onPageChanged: (index, reason) {
                                        _currentImage = index;
                                      }),
                                  items: List.from(imagePaths)
                                      .map((e) => Image.network(
                                            GetIt.I<ApiConfiguration>().secureBaseUrl + "w500" + e,
                                            height: 250,
                                          ))
                                      .toList(),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 15),
                                  decoration: BoxDecoration(color: Colors.red),
                                  child: TabBar(
                                    labelColor: Colors.redAccent,
                                    unselectedLabelColor: Colors.white,
                                    indicatorSize: TabBarIndicatorSize.label,
                                    indicatorColor: Colors.red,
                                    indicator: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.white),
                                    tabs: [
                                      Tab(
                                        child: Container(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text("Resumo"),
                                          ),
                                        ),
                                      ),
                                      Tab(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text("Infos"),
                                        ),
                                      ),
                                      Tab(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text("Vídeos"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 15),
                                    child: TabBarView(
                                      children: [
                                        Text(
                                          movieDetails.overview,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                margin: EdgeInsets.only(bottom: 10),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Lançamento: ",
                                                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                                                    ),
                                                    Text(DateFormat('dd/MM/yyyy').format(movieDetails.releaseDate),
                                                        style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400))
                                                  ],
                                                )),
                                            Container(
                                                margin: EdgeInsets.only(bottom: 10),
                                                child: Row(
                                                  children: [
                                                    Text("Orçamento: ",
                                                        style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600)),
                                                    Text(FormatHelper.formatMovieValues(movieDetails.budget),
                                                        style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400))
                                                  ],
                                                )),
                                            Row(
                                              children: [
                                                Text("Receita: ",
                                                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600)),
                                                Text(FormatHelper.formatMovieValues(movieDetails.revenue),
                                                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400))
                                              ],
                                            )
                                          ],
                                        ),
                                        Container(
                                          child: player,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                    }
                  },
                ));
          },
        ));
  }
}
