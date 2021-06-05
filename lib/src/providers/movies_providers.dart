import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:movie_app_21_2_21/src/models/actors_model.dart';
import 'package:movie_app_21_2_21/src/models/movies_model.dart';

class MovieProvider {
  String _apikey = '2d101404c1dd8f902862aba64d28099c';
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';
  // variables used by getPoupular
  int _popularPage = 0;
  bool _loading = false;
  List<Movie> _popular = new List();
  final _popularStreamController = StreamController<List<Movie>>.broadcast();
  // stream used by getPoupular
  Function(List<Movie>) get popularSink => _popularStreamController.sink.add;
  Stream<List<Movie>> get popularStream => _popularStreamController.stream;

  void disposeStreams() {
    _popularStreamController.close();
  }

  Future<dynamic> getDecodeData(
      String unencodedPath, Map<String, String> queryParameters) async {
    final url = Uri.https(_url, unencodedPath, queryParameters);
    final response = await http.get(url);
    final decodeData = json.decode(response.body);
    return decodeData;
  }

  Future<List<Movie>> getNowPLaying() async {
    final dynamic decodeData = await getDecodeData('3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
    });
    final movies = Movies.fromJsonList(decodeData['results']);

    return movies.items;
  }

  void getPopular() async {
    if (_loading) return;

    _loading = true;
    _popularPage++;

    final dynamic decodeData = await getDecodeData('3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': _popularPage.toString(),
    });
    final movies = Movies.fromJsonList(decodeData['results']);
    _popular.addAll(movies.items);
    popularSink(_popular);
    _loading = false;
  }

  Future<List<Actor>> getCast(String movieId) async {
    final dynamic decodeData = await getDecodeData('3/movie/$movieId/credits', {
      'api_key': _apikey,
      'language': _language,
    });
    final cast = Cast.fromJsonList(decodeData['cast']);
    return cast.actors;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final dynamic decodeData = await getDecodeData('3/search/movie', {
      'api_key': _apikey,
      'language': _language,
      'query' : query,
    });
    final movies = Movies.fromJsonList(decodeData['results']);

    return movies.items;
  }
}
