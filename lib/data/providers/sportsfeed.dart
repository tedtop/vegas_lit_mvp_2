import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:vegas_lit/config/api_keys.dart';
import 'package:vegas_lit/data/base_provider.dart';
import 'package:vegas_lit/data/models/game.dart';

class SportsfeedProvider extends BaseSportsfeedProvider {
  SportsfeedProvider({Dio dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  @override
  Future<List<Game>> fetchGameList() async {
    final response = await _dio.get(
      'https://sportspage-feeds.p.rapidapi.com/games',
      options: Options(
        headers: {
          'x-rapidapi-key': '${Api.apiKey}',
          'x-rapidapi-host': 'sportspage-feeds.p.rapidapi.com',
          'useQueryString': true
        },
      ),
    );
    if (response.statusCode == 200) {
      final List<dynamic> parsed =
          json.decode(json.encode(response.data))["results"];
      return parsed
          .map<Game>(
            (json) => Game.fromJson(json),
          )
          .toList();
    } else {
      throw FetchGameListFailure();
    }
  }

  @override
  Future<List<Game>> fetchGameListByGame({String gameName}) async {
    final response = await _dio.get(
      'https://sportspage-feeds.p.rapidapi.com/games',
      queryParameters: {"league": "$gameName"},
      options: Options(
        headers: {
          'x-rapidapi-key': '${Api.apiKey}',
          'x-rapidapi-host': 'sportspage-feeds.p.rapidapi.com',
          'useQueryString': true
        },
      ),
    );
    if (response.statusCode == 200) {
      final List<dynamic> parsed =
          json.decode(json.encode(response.data))["results"];
      return parsed
          .map<Game>(
            (json) => Game.fromJson(json),
          )
          .toList();
    } else {
      throw FetchGameListByGameFailure();
    }
  }
}

class FetchGameListByGameFailure implements Exception {}

class FetchGameListFailure implements Exception {}
