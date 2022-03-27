import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/movieDetailBloc/movie_detail_bloc.dart';
import 'package:movies_app/bloc/movieDetailBloc/movie_detail_event.dart';
import 'package:movies_app/bloc/movieDetailBloc/movie_detail_state.dart';
import 'package:movies_app/model/movie.dart';
import 'package:movies_app/model/movie_details.dart';
import 'package:movies_app/model/screen_shot.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MovieDetailBloc()..add(MovieDetailEventStart(movie.id)),
      child: WillPopScope(
        child: Scaffold(
          body: _buildMovieDetail(context),
        ),
        onWillPop: () async => true,
      ),
    );
  }

  Widget _buildMovieDetail(BuildContext context) {
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
      if (state is MovieDetailLoading) {
        return Center(
          child: Platform.isAndroid
              ? CircularProgressIndicator()
              : CupertinoActivityIndicator(),
        );
      } else if (state is MovieDetailLoaded) {
        MovieDetail movieDetail = state.movieDetail;
        print(movieDetail.title);
        print(movieDetail.trailerId);

        return SingleChildScrollView(
          child: Stack(
            children: [
              ClipPath(
                child: ClipRRect(
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://image.tmdb.org/t/p/original/${movieDetail.backdropPath}',
                      height: MediaQuery.of(context).size.height / 2,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (center, url) => Container(
                        width: 100,
                        height: 100,
                        child: Center(
                          child: Platform.isAndroid
                              ? CircularProgressIndicator()
                              : CupertinoActivityIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage('assets/images/img_not_found.jpg'),
                          ),
                        ),
                      ),
                    ),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 120),
                    child: GestureDetector(
                      onTap: () async {
                        print('youtube id : ${movieDetail.trailerId}');
                        final youtubeUrl =
                            'https://www.youtube.com/embed/${movieDetail.trailerId}';
                        if (await canLaunch(youtubeUrl)) {
                          await launch(youtubeUrl);
                        }
                      },
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.play_circle_outline,
                              color: Colors.yellow,
                              size: 65,
                            ),
                            Text(
                              movieDetail.title.toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Muli',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height,
                          child: Text(
                            movieDetail.overview,
                            maxLines: 25,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 15, fontFamily: 'Muli'),
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Дата выпуска',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Muli',
                                        ),
                                  ),
                                  Text(
                                    movieDetail.releaseDate,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(
                                          color: Colors.yellow[800],
                                          fontSize: 12,
                                          fontFamily: 'Muli',
                                        ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Продолжительность',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Muli',
                                        ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    '${movieDetail.runtime}:мин',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(
                                          color: Colors.yellow[800],
                                          fontSize: 12,
                                          fontFamily: 'Muli',
                                        ),
                                  ),
                                ],
                              ),

                              // Column(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: <Widget>[
                              //     Text(
                              //       'Бюджет',
                              //       style: Theme.of(context)
                              //           .textTheme
                              //           .caption
                              //           .copyWith(
                              //             fontWeight: FontWeight.bold,
                              //             //  fontFamily: 'Muli',
                              //           ),
                              //     ),
                              //     Text(
                              //       "${movieDetail.budget}",
                              //       style: Theme.of(context)
                              //           .textTheme
                              //           .subtitle2
                              //           .copyWith(
                              //             color: Colors.yellow[800],
                              //             fontSize: 12,
                              //             fontFamily: 'Muli',
                              //           ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
