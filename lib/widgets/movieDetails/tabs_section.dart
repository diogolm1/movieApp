import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/helpers/format_helper.dart';
import 'package:movie_app/models/movie_details.dart';
import 'package:movie_app/stores/movie/movie_details_store.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TabsSection extends StatefulWidget {
  final MovieDetails movieDetails;
  final List<String> videosIds;
  final Container youtubePlayer;
  final YoutubePlayerController ytController;
  TabsSection({this.movieDetails, this.videosIds, this.youtubePlayer, this.ytController});

  @override
  _TabsSectionState createState() => _TabsSectionState();
}

class _TabsSectionState extends State<TabsSection> {
  MovieDetailsStore movieDetailsStore = new MovieDetailsStore();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 15),
        child: TabBarView(
          children: [
            Text(
              widget.movieDetails.overview,
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
                        Text(DateFormat('dd/MM/yyyy').format(widget.movieDetails.releaseDate),
                            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400))
                      ],
                    )),
                Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Text("Orçamento: ", style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600)),
                        Text(FormatHelper.formatMovieValues(widget.movieDetails.budget),
                            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400))
                      ],
                    )),
                Row(
                  children: [
                    Text("Receita: ", style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600)),
                    Text(FormatHelper.formatMovieValues(widget.movieDetails.revenue),
                        style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400))
                  ],
                )
              ],
            ),
            widget.movieDetails.videos.length > 0
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
                      items: List.from(widget.movieDetails.videos)
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
                                            children: List.from(widget.movieDetails.videos)
                                                .map(
                                                  (e) => Container(
                                                    width: movieDetailsStore.currentVideo ==
                                                            widget.movieDetails.videos.indexOf(e)
                                                        ? 12.0
                                                        : 8.0,
                                                    height: movieDetailsStore.currentVideo ==
                                                            widget.movieDetails.videos.indexOf(e)
                                                        ? 12.0
                                                        : 8.0,
                                                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: movieDetailsStore.currentVideo ==
                                                              widget.movieDetails.videos.indexOf(e)
                                                          ? Colors.red
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
