import 'package:equatable/equatable.dart';
import 'package:movies_app/model/movie_details.dart';

abstract class MovieDetailState extends Equatable {
  MovieDetailState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailError extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail movieDetail;

  MovieDetailLoaded(this.movieDetail);

  @override
  // TODO: implement props
  List<Object> get props => [movieDetail];
}
