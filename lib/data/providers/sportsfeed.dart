import 'dart:convert';

import 'package:dio/dio.dart';
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
          'x-rapidapi-key':
              '43152108e9msh76cb1b1f55c77efp166888jsne1864e4b19af',
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
}

class FetchGameListFailure implements Exception {}
