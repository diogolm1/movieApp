import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/helpers/format_helper.dart';
import 'package:movie_app/models/apiConfiguration.dart';
import 'package:movie_app/models/movie_details.dart';
import 'package:movie_app/models/series_details.dart';
import 'package:movie_app/stores/movie/movie_details_store.dart';
import 'package:movie_app/widgets/actor_card.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SeriesTabs extends StatefulWidget {
  final SeriesDetails seriesDetails;
  final List<String> videosIds;
  final Container youtubePlayer;
  final YoutubePlayerController ytController;
  SeriesTabs({this.seriesDetails, this.videosIds, this.youtubePlayer, this.ytController});

  @override
  _SeriesTabsState createState() => _SeriesTabsState();
}

class _SeriesTabsState extends State<SeriesTabs> {
  MovieDetailsStore movieDetailsStore = new MovieDetailsStore();

  @override
  Widget build(BuildContext context) {
    List<String> actorsImagePaths = widget.seriesDetails.actors
        .where((element) => element.profilePath != null && element.profilePath != "")
        .map((e) => e.profilePath)
        .toList();
    String baseUrl = GetIt.I<ApiConfiguration>().secureBaseUrl;
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 15),
        child: TabBarView(
          children: [
            SingleChildScrollView(
              child: Text(
                widget.seriesDetails.overview,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SingleChildScrollView(
              child: Column(
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
                          Text(DateFormat('dd/MM/yyyy').format(widget.seriesDetails.firstAirDate),
                              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400))
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Text("Temporadas: ", style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600)),
                          Text(widget.seriesDetails.numberOfSeasons.toString(),
                              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400))
                        ],
                      )),
                  Container(
                    child: Row(
                      children: [
                        Text("Episódios: ", style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600)),
                        Text(widget.seriesDetails.numberOfEpisodes.toString(),
                            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: SizedBox(
                      height: 195,
                      child: Container(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: actorsImagePaths.length,
                          itemBuilder: (_, index) => ActorCard(
                            baseUrl: baseUrl,
                            character: widget.seriesDetails.actors[index].character,
                            imagePath: actorsImagePaths[index],
                            name: widget.seriesDetails.actors[index].name,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            widget.seriesDetails.videos.length > 0
                ? Container(
                    child: CarouselSlider(
                      options: CarouselOptions(
                          viewportFraction: 1.0,
                          enlargeCenterPage: false,
                          enableInfiniteScroll: false,
                          autoPlay: false,
                          onPageChanged: (index, reason) {
                            movieDetailsStore.setCurrentVideo(index);
                            widget.ytController.cue(widget.videosIds[index]);
                          }),
                      items: List.from(widget.seriesDetails.videos)
                          .map((e) => Column(
                                children: [
                                  Container(margin: EdgeInsets.only(bottom: 10), child: Text(e.name)),
                                  Expanded(
                                      child: Container(
                                    child: widget.youtubePlayer,
                                  )),
                                  Observer(
                                      builder: (_) => Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: List.from(widget.seriesDetails.videos)
                                                .map(
                                                  (e) => Container(
                                                    width: movieDetailsStore.currentVideo ==
                                                            widget.seriesDetails.videos.indexOf(e)
                                                        ? 12.0
                                                        : 8.0,
                                                    height: movieDetailsStore.currentVideo ==
                                                            widget.seriesDetails.videos.indexOf(e)
                                                        ? 12.0
                                                        : 8.0,
                                                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: movieDetailsStore.currentVideo ==
                                                              widget.seriesDetails.videos.indexOf(e)
                                                          ? Theme.of(context).primaryColor
                                                          : Colors.grey,
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                          ))
                                ],
                              ))
                          .toList(),
                    ),
                  )
                : Container(
                    child: Text(
                    "Nenhum vídeo disponível.",
                    textAlign: TextAlign.center,
                  ))
          ],
        ),
      ),
    );
  }
}
