import 'package:equatable/equatable.dart';

abstract class MovieDetailEvent extends Equatable {
  MovieDetailEvent();
}

class MovieDetailEventStart extends MovieDetailEvent {
  final int id;

  MovieDetailEventStart(this.id);

  @override
  // TODO: implement props
  List<Object> get props => [];
}
