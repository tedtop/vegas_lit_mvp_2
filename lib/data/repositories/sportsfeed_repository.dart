import 'package:vegas_lit/data/models/game.dart';
import 'package:vegas_lit/data/providers/sportsfeed.dart';

class SportsfeedRepository {
  final _baseSportsfeedProvider = SportsfeedProvider();

  Future<List<Game>> fetchGameList() => _baseSportsfeedProvider.fetchGameList();
}
