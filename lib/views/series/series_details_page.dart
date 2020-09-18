import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/models/apiConfiguration.dart';
import 'package:movie_app/models/series_details.dart';
import 'package:movie_app/repositories/seriesRepository.dart';
import 'package:movie_app/widgets/series/series_tabs.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SeriesDetailsPage extends StatefulWidget {
  final int serieId;
  final String title;

  const SeriesDetailsPage({this.serieId, this.title});

  @override
  _SeriesDetailsState createState() => _SeriesDetailsState();
}

class _SeriesDetailsState extends State<SeriesDetailsPage> {
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
                    title: Text(widget.title), centerTitle: true, backgroundColor: Theme.of(context).primaryColorDark),
                body: FutureBuilder(
                  future: SeriesRepository.instance.getSeriesDetails(widget.serieId),
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
                          SeriesDetails seriesDetails = snapshot.data;
                          List<String> imagePaths = seriesDetails.getImagePaths();
                          videosIds = seriesDetails.videos.map((e) => e.key).toList();
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                CarouselSlider(
                                  options: CarouselOptions(
                                      viewportFraction: 1.0,
                                      enlargeCenterPage: false,
                                      enableInfiniteScroll: true,
                                      autoPlay: true),
                                  items: List.from(imagePaths)
                                      .map((e) => Image.network(
                                            GetIt.I<ApiConfiguration>().secureBaseUrl + "w500" + e,
                                            height: 250,
                                          ))
                                      .toList(),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 15),
                                  decoration: BoxDecoration(color: Theme.of(context).primaryColorDark),
                                  child: TabBar(
                                    labelColor: Theme.of(context).primaryColorDark,
                                    unselectedLabelColor: Colors.white,
                                    indicatorSize: TabBarIndicatorSize.label,
                                    indicatorColor: Theme.of(context).primaryColorDark,
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
                                SeriesTabs(
                                  seriesDetails: seriesDetails,
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
