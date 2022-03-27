import 'package:dio/dio.dart';
import 'package:movies_app/model/genre.dart';
import 'package:movies_app/model/movie.dart';
import 'package:movies_app/model/movie_details.dart';
import 'package:movies_app/model/movie_image.dart';

class ApiService {
  final Dio _dio = Dio();

  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKey = 'api_key=f173d5ac10799aab4d425a28346db78e';

  Future<List<Movie>> getNowPlayingMovie() async {
    try {
      print('api call');
      final url = '$baseUrl/movie/now_playing?$apiKey&language=ru-RU';
      print('api call $url');
      final responce = await _dio.get(url);
      var movies = responce.data['results'] as List;
      print('apiServer movies:$movies');
      List<Movie> movieslist = movies.map((m) => Movie.fromJson(m)).toList();
      return movieslist;
    } catch (error, stacktrace) {
      print('ApiService error');
      throw Exception('Exception accoured:$error with stacktrace:$stacktrace');
    }
  }

//  https://api.themoviedb.org/3/genre/movie/list?api_key=f173d5ac10799aab4d425a28346db78e
  Future<List<Genre>> getGenreList() async {
    try {
      final responce =
          await _dio.get('$baseUrl/genre/movie/list?$apiKey&language=ru-RU');
      print('api call genrelist $responce');
      var genres = responce.data['genres'] as List;
      List<Genre> genreslist = genres.map((g) => Genre.fromJson(g)).toList();
      return genreslist;
    } catch (error, stacktrace) {
      print('ApiService Genre error');
      throw Exception('Exception accoured:$error with stacktrace:$stacktrace');
    }
  }

//https://api.themoviedb.org/3/discover/movie?with_genres=$movieId&api_key=f173d5ac10799aab4d425a28346db78e
  Future<List<Movie>> getMovieByGenre(int movieId) async {
    try {
      final url =
          '$baseUrl/discover/movie?with_genres=$movieId&$apiKey&language=ru-RU';
      print('api call getMovieByGenre $url');
      final responce = await _dio.get(url);
      var movies = responce.data['results'] as List;
      List<Movie> movieslist = movies.map((e) => Movie.fromJson(e)).toList();
      return movieslist;
    } catch (error, stacktrace) {
      print('ApiService getMovieByGenre error');
      throw Exception('Exception accoured:$error with stacktrace:$stacktrace');
    }
  }

//  https://api.themoviedb.org/3/discover/movie?with_genres=$movieId&api_key=f173d5ac10799aab4d425a28346db78e
  Future<MovieDetail> getMovieDetail(int movieId) async {
    try {
      final responce =
          await _dio.get('$baseUrl/movie/$movieId?$apiKey&language=ru-RU');
      print('getMovieDetail:${responce}');
      MovieDetail movieDetail = MovieDetail.fromJson(responce.data);
      movieDetail.trailerId = await getYoutubeId(movieId);
      return movieDetail;
    } catch (error, stacktrace) {
      print('ApiService getMovieDetail error');
      throw Exception('Exception accoured:$error with stacktrace:$stacktrace');
    }
  }

  Future<String> getYoutubeId(int id) async {
    try {
      final response =
          await _dio.get('$baseUrl/movie/$id/videos?$apiKey&language=ru-RU');
      var youtubeId = response.data['results'][0]['key'];
      return youtubeId;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<MovieImage> getMovieImage(int movieId) async {
    try {
      final response = await _dio.get('$baseUrl/movie/$movieId/images?$apiKey');
      return MovieImage.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }
}
