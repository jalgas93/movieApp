import 'package:equatable/equatable.dart';
import 'package:movies_app/model/genre.dart';

abstract class GenreState extends Equatable {
  const GenreState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GenreLoading extends GenreState {}

class GenreError extends GenreState {}

class GenreLoaded extends GenreState {
  final List<Genre> genrelist;

  GenreLoaded({this.genrelist});

  @override
  // TODO: implement props
  List<Object> get props => [genrelist];
}
