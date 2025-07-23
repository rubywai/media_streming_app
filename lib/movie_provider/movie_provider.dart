import 'package:flutter/material.dart';

import '../data/movie_api_service.dart';
import '../data/movie_response.dart';

class MovieProvider extends ChangeNotifier {
  List<MovieResponse> movieList = [];
  bool isLoading = true;
  bool isSuccess = false;
  bool isFailed = false;
  final MovieApiService _service = MovieApiService();
  void getMovies() async {
    try {
      isLoading = true;
      isSuccess = false;
      isFailed = false;
      notifyListeners();
      movieList = await _service.getMovies();
      isSuccess = true;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      isFailed = true;
      notifyListeners();
    }
  }
}
