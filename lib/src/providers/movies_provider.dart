import 'package:movies/src/models/movie.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MoviesProvider {
  String _apiKey = 'cdf449483f6859c51996711abcb4990c';
  String _url = 'api.themoviedb.org';
  String _languaje = 'es-CO';

  Future<List<Movie>> getOnCinemas() async {
    final queryStrings = {
      'api_key': _apiKey,
      'language': _languaje,
    };
    final url = Uri.https(_url, '3/movie/upcoming', queryStrings);

    return await _processResponse(url);
  }

  Future<List<Movie>> _processResponse(Uri url) async {
    final response = await http.get(url);
    final decodeData = json.decode(response.body);

    final movies = new Movies.fromJsonList(decodeData["results"]);

    return movies.movies;
  }
}
