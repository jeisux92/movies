import 'dart:async';
import 'package:movies/src/models/actor.dart';
import 'package:movies/src/models/movie.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MoviesProvider {
  String _url = 'api.themoviedb.org';
  int _popularesPage = 0;
  bool _loading = false;
  List<Movie> _populars = [];
  final queryStrings = {
    'api_key': 'cdf449483f6859c51996711abcb4990c',
    'language': 'es-CO',
  };

  final StreamController<List<Movie>> _popularsStreamController =
      StreamController<List<Movie>>.broadcast();

  void disposeStreams() {
    _popularsStreamController?.close();
  }

  Function(List<Movie>) get popularsSink => _popularsStreamController.sink.add;

  Stream<List<Movie>> get popularsStream => _popularsStreamController.stream;

  Future<List<Movie>> getOnCinemas() async {
    final url = Uri.https(_url, '3/movie/upcoming', queryStrings);
    try {
      final response = await http.get(url);
      final decodeData = json.decode(response.body);
      final movies = new Movies.fromJsonList(decodeData["results"]);
      return movies.movies;
    } catch (e) {
      return [];
    }
  }

  Future<List<Movie>> getPopulars() async {
    if (_loading) {
      return [];
    }
    _loading = true;
    _popularesPage++;
    final queryString = {
      'page': _popularesPage.toString(),
      ...queryStrings,
    };
    final url = Uri.https(_url, '3/movie/popular/', queryString);
    try {
      final response = await http.get(url);
      final decodeData = json.decode(response.body);
      final movies = new Movies.fromJsonList(decodeData["results"]);

      _populars.addAll(movies.movies);
      popularsSink(_populars);
      _loading = false;
      return movies.movies;
    } catch (e) {
      return [];
    }
  }

  Future<List<Actor>> getCast(int peliId) async {
    final url = Uri.https(_url, '3/movie/$peliId/credits', queryStrings);
    final resp = await http.get(url);
    final decode = json.decode(resp.body);
    final cast = new Cast.fromJsonMap(decode['cast']);
    return cast.actors;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final queryString = {
      'query': query,
      ...queryStrings,
    };

    final url = Uri.https(_url, '3/search/movie', queryString);

    final response = await http.get(url);
    final decodeData = json.decode(response.body);
    final movies = new Movies.fromJsonList(decodeData["results"]);
    return movies.movies;
  }
}
