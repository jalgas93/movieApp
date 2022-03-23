import 'package:equatable/equatable.dart';
import 'package:movies_app/model/movie.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class MovieLoading extends MovieState {}

class MovieError extends MovieState {}

class MovieLoaded extends MovieState {
  final List<Movie> movielist;

  const MovieLoaded(this.movielist);

  @override
  // TODO: implement props
  List<Object> get props => [movielist];
}
