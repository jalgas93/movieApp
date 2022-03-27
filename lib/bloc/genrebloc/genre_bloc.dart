import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/genrebloc/genre_event.dart';
import 'package:movies_app/bloc/genrebloc/genre_state.dart';
import 'package:movies_app/model/genre.dart';
import 'package:movies_app/service/api_service.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  GenreBloc() : super(GenreLoading());

  @override
  Stream<GenreState> mapEventToState(GenreEvent event) async* {
    // TODO: implement mapEventToState
    if (event is GenreEventStarted) {
      yield* _mapGenreEventStateToState();
    }
  }

  Stream<GenreState> _mapGenreEventStateToState() async* {
    final service = ApiService();
    yield GenreLoading();
    try {
       print('apiCall genre');
      List<Genre> genrelist = await service.getGenreList();
          print('genreList:${genrelist}');
      yield GenreLoaded(genrelist: genrelist);
    } on Exception catch (e) {
      print('GenreError${e}');
      yield GenreError();
    }
  }
}
