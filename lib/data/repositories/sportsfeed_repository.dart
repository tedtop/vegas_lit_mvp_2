import 'package:vegas_lit/data/models/game.dart';
import 'package:vegas_lit/data/providers/sportspage.dart';

class SportsfeedRepository {
  final _baseSportsfeedProvider = SportsfeedProvider();

  Future<List<Game>> fetchGameList() => _baseSportsfeedProvider.fetchGameList();
  Future<List<Game>> fetchGameListByGame({String gameName}) =>
      _baseSportsfeedProvider.fetchGameListByGame(gameName: gameName);
}
