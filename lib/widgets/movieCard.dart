import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/models/apiConfiguration.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/views/movie_details_page.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final ApiConfiguration apiConfig = GetIt.I<ApiConfiguration>();

  MovieCard({Key key, this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => MovieDetailsPage(
                        movieId: movie.id,
                        title: movie.title,
                      )));
        },
        child: Card(
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  apiConfig.secureBaseUrl + "w500" + movie.posterPath,
                  width: 100,
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            movie.title,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Text(
                            movie.overview,
                            textAlign: TextAlign.start,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.calendarAlt,
                                size: 18,
                              ),
                              Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  child: Text(DateFormat('dd/MM/yyyy').format(movie.releaseDate)))
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                movie.voteAverage.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3.0),
                              color: movie.voteAverage < 4.0
                                  ? Colors.red[300]
                                  : movie.voteAverage < 8.0 ? Colors.yellow[800] : Colors.green[300]),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
