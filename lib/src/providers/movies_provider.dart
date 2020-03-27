import 'dart:async';

import 'package:movies/src/models/movie.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MoviesProvider {
  String _apiKey = 'cdf449483f6859c51996711abcb4990c';
  String _url = 'api.themoviedb.org';
  String _languaje = 'es-CO';
  int _popularesPage = 0;
  bool _loading = false;
  List<Movie> _populars = [];

  final StreamController<List<Movie>> _popularsStreamController =
      StreamController<List<Movie>>.broadcast();

  void disposeStreams() {
    _popularsStreamController?.close();
  }

  Function(List<Movie>) get popularsSink => _popularsStreamController.sink.add;

  Stream<List<Movie>> get popularsStream => _popularsStreamController.stream;

  Future<List<Movie>> getOnCinemas() async {
    final queryStrings = {
      'api_key': _apiKey,
      'language': _languaje,
    };
    final url = Uri.https(_url, '3/movie/upcoming', queryStrings);

    return await _processResponse(url);
  }

  Future<List<Movie>> getPopulars() async {
    if (_loading) {
      return [];
    }
    _loading = true;
    _popularesPage++;
    final queryStrings = {
      'api_key': _apiKey,
      'language': _languaje,
      'page': _popularesPage.toString()
    };
    final url = Uri.https(_url, '3/movie/popular/', queryStrings);
    final List<Movie> response = await _processResponse(url);
    _populars.addAll(response);
    popularsSink(_populars);
    _loading = false;
    return response;
  }

  Future<List<Movie>> _processResponse(Uri url) async {
    final response = await http.get(url);
    final decodeData = json.decode(response.body);
    final movies = new Movies.fromJsonList(decodeData["results"]);
    return movies.movies;
  }
}
