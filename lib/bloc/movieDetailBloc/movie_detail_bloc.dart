import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/movieDetailBloc/movie_detail_event.dart';
import 'package:movies_app/bloc/movieDetailBloc/movie_detail_state.dart';
import 'package:movies_app/service/api_service.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc() : super(MovieDetailLoading());

  @override
  Stream<MovieDetailState> mapEventToState(MovieDetailEvent event) async* {
    // TODO: implement mapEventToState
    if (event is MovieDetailEventStart) {
      yield* _mapMovieDetailEventToState(event.id);
    }
  }

  Stream<MovieDetailState> _mapMovieDetailEventToState(int id) async* {
    final apiService = ApiService();
    yield MovieDetailLoading();
    try {
      final movieDetail = await apiService.getMovieDetail(id);
      print('apiCallMovieDetail:${movieDetail}');
      yield  MovieDetailLoaded(movieDetail);
    } on Exception catch (e) {
      print(e);
      yield MovieDetailError();
    }
  }
}
