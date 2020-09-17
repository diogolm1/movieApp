import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/models/apiConfiguration.dart';
import 'package:movie_app/models/movie_details.dart';
import 'package:movie_app/repositories/movieRepository.dart';
import 'package:movie_app/widgets/movieDetails/tabs_section.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailsPage extends StatefulWidget {
  final int movieId;
  final String title;

  const MovieDetailsPage({this.movieId, this.title});

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetailsPage> {
  YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: '',
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: true,
      ));
  List<String> videosIds;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _controller,
            onReady: () => videosIds.length > 0 ? _controller.cue(videosIds.first) : null,
            thumbnail: Container(),
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
                          videosIds = movieDetails.videos.map((e) => e.key).toList();
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                CarouselSlider(
                                  options: CarouselOptions(
                                    viewportFraction: 1.0,
                                    enlargeCenterPage: false,
                                    enableInfiniteScroll: true,
                                    autoPlay: true,
                                  ),
                                  items: List.from(imagePaths)
                                      .map((e) => Image.network(
                                            GetIt.I<ApiConfiguration>().secureBaseUrl + "w500" + e,
                                            height: 250,
                                          ))
                                      .toList(),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 15),
                                  decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                                  child: TabBar(
                                    labelColor: Theme.of(context).primaryColor,
                                    unselectedLabelColor: Colors.white,
                                    indicatorSize: TabBarIndicatorSize.label,
                                    indicatorColor: Theme.of(context).primaryColor,
                                    indicator: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                        color: Colors.white),
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
                                TabsSection(
                                  movieDetails: movieDetails,
                                  youtubePlayer: player,
                                  ytController: _controller,
                                  videosIds: videosIds,
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
