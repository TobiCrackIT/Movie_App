import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider_arch/model/movie.dart';
import 'package:provider_arch/remote/api.dart';
import 'package:provider_arch/utils/status.dart';

class HomeViewModel with ChangeNotifier {
  var _myApi = API();
  List<Movie> popularMoviesList;
  List<Movie> topRatedMoviesList;
  Status _currentStatus = Status.LOADING;
  String _errorMessage;

  HomeViewModel();

  List<Movie> getPopularMoviesList() {
    return popularMoviesList;
  }

  List<Movie> getTopRatedMoviesList() {
    return topRatedMoviesList;
  }

  String getErrorMessage() {
    return _errorMessage;
  }

  Status getCurrentStatus() {
    return _currentStatus;
  }

  void setErrorMessage(String message){
    _errorMessage=message;
    notifyListeners();
  }

  void getPopularMovies() {
    _currentStatus = Status.LOADING;
    notifyListeners();
    _myApi.fetchPopularMovies().then((response) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        _currentStatus = Status.SUCCESSFUL;
        popularMoviesList =
            MovieList.fromJson(json.decode(response.body)['results']).movieList;
        notifyListeners();
      } else {
        _currentStatus = Status.FAILED;
        _errorMessage = json.decode(response.body)['message'];
      }
    }).catchError((error) {
      _currentStatus = Status.FAILED;
      _errorMessage = "An unknown error occurred";
      notifyListeners();
    });
  }

  void getTopRatedMovies() {
    _currentStatus = Status.LOADING;
    notifyListeners();
    _myApi.fetchTopRatedMovies().then((response) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        _currentStatus = Status.SUCCESSFUL;
        topRatedMoviesList =
            MovieList.fromJson(json.decode(response.body)['results']).movieList;
        notifyListeners();
      } else {
        _currentStatus = Status.FAILED;
        _errorMessage = json.decode(response.body)['message'];
      }
    }).catchError((error) {
      _currentStatus = Status.FAILED;
      _errorMessage = "An unknown error occurred";
      notifyListeners();
    });
  }
}
