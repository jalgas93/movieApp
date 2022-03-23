import 'package:dio/dio.dart';
import 'package:movies_app/model/movie.dart';

class ApiService {
  final Dio _dio = Dio();

  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKey = 'api_key=f173d5ac10799aab4d425a28346db78e';

  Future<List<Movie>> getNowPlayingMovie() async {
    try {
      print('api call');
      final url = '$baseUrl/movie/now_playing?$apiKey';
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
}
