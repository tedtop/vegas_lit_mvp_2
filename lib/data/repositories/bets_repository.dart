import 'package:vegas_lit/data/models/open_bets.dart';
import 'package:vegas_lit/data/providers/database.dart';

import '../base_provider.dart';

class BetsRepository {
  final BaseDatabaseProvider _databaseProvider = DatabaseProvider();

  Stream<List<OpenBets>> fetchOpenBetsByUserId(String currentUserId) =>
      _databaseProvider.fetchOpenBetsById(currentUserId);
}
