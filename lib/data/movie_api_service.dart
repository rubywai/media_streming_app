import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'movie_response.dart';

class MovieApiService {
  final Dio _dio = Dio()
    ..options.baseUrl = "https://videoapi.rubylearner.com/"
    ..interceptors.add(
      PrettyDioLogger(
        responseBody: true,
      ),
    );
  Future<List<MovieResponse>> getMovies() async {
    final response = await _dio.get("api");
    return (response.data as List)
        .map(
          (e) => MovieResponse.fromJson(e),
        )
        .toList();
  }
}
