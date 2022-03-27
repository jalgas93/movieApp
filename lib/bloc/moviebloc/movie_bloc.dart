import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/moviebloc/movie_bloc_event.dart';
import 'package:movies_app/bloc/moviebloc/movie_bloc_state.dart';
import 'package:movies_app/model/movie.dart';
import 'package:movies_app/service/api_service.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() :super(MovieLoading());

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    // TODO: implement mapEventToState
    if (event is MovieEventStarted) {
      yield* _mapMovieEventStateToState(event.movieId, event.query);
    }
  }


  Stream<MovieState> _mapMovieEventStateToState(int movieId,
      String query) async* {
    final service = ApiService();
    yield MovieLoading();
    try {
      List<Movie> movielist;
      if (movieId == 0) {
        movielist = await service.getNowPlayingMovie();
      }
      else {
         movielist = await service.getMovieByGenre(movieId);
      }
      yield MovieLoaded(movielist);
    } on Exception
    catch (e) {
      print('bloc error:${e}');
      yield MovieError();
    }
  }
}