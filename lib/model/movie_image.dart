import 'package:equatable/equatable.dart';
import 'package:movies_app/model/screen_shot.dart';

class MovieImage extends Equatable {
  final List<Screenshot> backdrops;
  final List<Screenshot> posters;

  MovieImage({this.backdrops, this.posters});

  factory MovieImage.fromJson(Map<String, dynamic> result) {
    if (result == null) {
      return MovieImage();
    }
    return MovieImage(
      backdrops: (result['backdrops'] as List)
              ?.map((e) => MovieImage.fromJson(e))
              ?.toList() ??
          List.empty(),
      posters: (result['posters'] as List)
              ?.map((b) => MovieImage.fromJson(b))
              ?.toList() ??
          List.empty(),
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [backdrops, posters];
}
