import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pruebamovieavilatek/src/models/movie_credits.dart';
import 'package:pruebamovieavilatek/src/models/movie_credits_person.dart'
    as person;
import 'package:pruebamovieavilatek/src/models/movie_popular.dart';
import 'package:pruebamovieavilatek/src/models/person.dart';

class HttpServices {
  final String _apiKey = 'deba4eb245b37cd2c1fe660a18397adc';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  Future<List<Result>?> getLastestMovie() async {
    var url = Uri.https(_baseUrl, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
    });

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final decodedData = MoviePopular.fromJson(json.decode(response.body));

      return decodedData.results;
    }
    return null;
  }

  Future<List<Cast>?> getMovieCredits(int movieId) async {
    var url = Uri.https(_baseUrl, '3/movie/$movieId/credits', {
      'api_key': _apiKey,
      'language': _language,
    });

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final decodedData = MovieCredits.fromJson(json.decode(response.body));

      return decodedData.cast;
    }
    return null;
  }

  Future<People?> getPeopleBio(int peopleId) async {
    var url = Uri.https(_baseUrl, '3/person/$peopleId', {
      'api_key': _apiKey,
      'language': _language,
    });

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final decodedData = People.fromJson(json.decode(response.body));

      return decodedData;
    }
  }

  Future<List<person.Cast>?> getMovieCreditsPerson(int id) async {
    var url = Uri.https(_baseUrl, '3/person/$id/movie_credits', {
      'api_key': _apiKey,
      'language': _language,
    });

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final decodedData =
          person.MovieCreditsPerson.fromJson(json.decode(response.body));

      return decodedData.cast;
    }
    return null;
  }
}
