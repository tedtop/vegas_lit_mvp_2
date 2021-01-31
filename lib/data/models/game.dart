import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:vegas_lit/constants/assets.dart';

const String jsonAssetPath = Json.mockData;

class Game extends Equatable {
  final GameSchedule schedule;
  final String summary;
  final GameDetails details;
  final String status;
  final GameTeams teams;
  final DateTime lastUpdated;
  final int gameId;
  final GameVenue venue;
  final List<GameOdds> odds;

  Game({
    this.schedule,
    this.summary,
    this.details,
    this.status,
    this.teams,
    this.lastUpdated,
    this.gameId,
    this.venue,
    this.odds,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    final List<GameOdds> odds = json['odds'].map<GameOdds>(
      (json) {
        return GameOdds.fromJson(json);
      },
    ).toList();
    return Game(
      schedule: GameSchedule.fromJson(
        json['schedule'],
      ),
      summary: json['summary'],
      details: GameDetails.fromJson(
        json['details'],
      ),
      status: json['status'],
      teams: GameTeams.fromJson(
        json['teams'],
      ),
      lastUpdated: DateTime.parse(
        json['lastUpdated'],
      ),
      gameId: json['gameId'],
      venue: GameVenue.fromJson(
        json['venue'],
      ),
      odds: odds,
    );
  }

  static Future<List<Game>> fetchAllFromMock() async {
    final dynamic gamesJson = json.decode(
      await rootBundle.loadString(jsonAssetPath),
    );
    final List<dynamic> parsed = gamesJson['results'];
    return parsed
        .map<Game>(
          (json) => Game.fromJson(json),
        )
        .toList();
  }

  @override
  List<Object> get props {
    return [
      schedule,
      summary,
      details,
      status,
      teams,
      lastUpdated,
      gameId,
      venue,
      odds,
    ];
  }
}

class GameSchedule extends Equatable {
  final DateTime date;
  final dynamic tbaTime;

  GameSchedule({
    this.date,
    this.tbaTime,
  });

  factory GameSchedule.fromJson(Map<String, dynamic> json) {
    return GameSchedule(
      date: DateTime.parse(json['date']),
      tbaTime: json['tbaTime'],
    );
  }

  @override
  List<Object> get props => [date, tbaTime];
}

class GameDetails extends Equatable {
  final String league;
  final String seasonType;
  final int season;
  final bool conferenceGame;
  final bool divisionGame;

  GameDetails({
    this.league,
    this.seasonType,
    this.season,
    this.conferenceGame,
    this.divisionGame,
  });

  factory GameDetails.fromJson(Map<String, dynamic> json) {
    return GameDetails(
      league: json['league'],
      seasonType: json['seasonType'],
      season: json['season'],
      conferenceGame: json['conferenceGame'],
      divisionGame: json['divisionGame'],
    );
  }

  @override
  List<Object> get props {
    return [
      league,
      seasonType,
      season,
      conferenceGame,
      divisionGame,
    ];
  }
}

class GameTeams extends Equatable {
  final GameTeam away;
  final GameTeam home;

  GameTeams({
    this.away,
    this.home,
  });

  factory GameTeams.fromJson(Map<String, dynamic> json) {
    return GameTeams(
      away: GameTeam.fromJson(json['away']),
      home: GameTeam.fromJson(json['home']),
    );
  }

  @override
  List<Object> get props => [away, home];
}

class GameTeam extends Equatable {
  final String team;
  final String location;
  final String mascot;
  final String abbreviation;
  final String conference;
  final String division;

  GameTeam({
    this.team,
    this.location,
    this.mascot,
    this.abbreviation,
    this.conference,
    this.division,
  });

  factory GameTeam.fromJson(Map<String, dynamic> json) {
    return GameTeam(
      team: json['team'],
      location: json['location'],
      mascot: json['mascot'],
      abbreviation: json['abbreviation'],
      conference: json['conference'],
      division: json['division'],
    );
  }

  @override
  List<Object> get props {
    return [
      team,
      location,
      mascot,
      abbreviation,
      conference,
      division,
    ];
  }
}

class GameVenue extends Equatable {
  final String name;
  final String city;
  final String state;
  final bool neutralSite;

  GameVenue({
    this.name,
    this.city,
    this.state,
    this.neutralSite,
  });

  factory GameVenue.fromJson(Map<String, dynamic> json) {
    return GameVenue(
      name: json['name'],
      city: json['city'],
      state: json['state'],
      neutralSite: json['neutralSite'],
    );
  }

  @override
  List<Object> get props => [name, city, state, neutralSite];
}

class GameOdds extends Equatable {
  final GameSpreadOdds spread;
  final GameMoneylineOdds moneyline;
  final GameTotalOdds total;
  final DateTime openDate;
  final DateTime lastUpdated;

  GameOdds({
    this.spread,
    this.moneyline,
    this.total,
    this.openDate,
    this.lastUpdated,
  });

  factory GameOdds.fromJson(Map<String, dynamic> json) {
    return GameOdds(
      spread: GameSpreadOdds.fromJson(json['spread']),
      moneyline: GameMoneylineOdds.fromJson(json['moneyline']),
      total: GameTotalOdds.fromJson(json['total']),
      openDate: DateTime.parse(json['openDate']),
      lastUpdated: DateTime.parse(json['lastUpdated']),
    );
  }

  @override
  List<Object> get props {
    return [
      spread,
      moneyline,
      total,
      openDate,
      lastUpdated,
    ];
  }
}

class GameSpreadOdds extends Equatable {
  final GameSpreadOddsDetail open;
  final GameSpreadOddsDetail current;

  GameSpreadOdds({
    this.open,
    this.current,
  });

  factory GameSpreadOdds.fromJson(Map<String, dynamic> json) {
    return GameSpreadOdds(
      open: GameSpreadOddsDetail.fromJson(json['open']),
      current: GameSpreadOddsDetail.fromJson(json['current']),
    );
  }

  @override
  List<Object> get props => [open, current];
}

class GameSpreadOddsDetail extends Equatable {
  final double away;
  final double home;
  final int awayOdds;
  final int homeOdds;

  GameSpreadOddsDetail({
    this.away,
    this.home,
    this.awayOdds,
    this.homeOdds,
  });

  factory GameSpreadOddsDetail.fromJson(Map<String, dynamic> json) {
    return GameSpreadOddsDetail(
      away: json['away'].toDouble(),
      home: json['home'].toDouble(),
      awayOdds: json['awayOdds'],
      homeOdds: json['homeOdds'],
    );
  }

  @override
  List<Object> get props => [away, home, awayOdds, homeOdds];
}

class GameMoneylineOdds extends Equatable {
  final GameMoneylineOddsDetail open;
  final GameMoneylineOddsDetail current;

  GameMoneylineOdds({
    this.open,
    this.current,
  });

  factory GameMoneylineOdds.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      return GameMoneylineOdds(
        open: GameMoneylineOddsDetail.fromJson(json['open']),
        current: GameMoneylineOddsDetail.fromJson(json['current']),
      );
    } else {
      return GameMoneylineOdds(
        open: GameMoneylineOddsDetail(awayOdds: 0, homeOdds: 0),
        current: GameMoneylineOddsDetail(awayOdds: 0, homeOdds: 0),
      );
    }
  }

  @override
  List<Object> get props => [open, current];
}

class GameMoneylineOddsDetail extends Equatable {
  final int awayOdds;
  final int homeOdds;

  GameMoneylineOddsDetail({
    this.awayOdds,
    this.homeOdds,
  });

  factory GameMoneylineOddsDetail.fromJson(Map<String, dynamic> json) {
    return GameMoneylineOddsDetail(
      awayOdds: json['awayOdds'],
      homeOdds: json['homeOdds'],
    );
  }

  @override
  List<Object> get props => [awayOdds, homeOdds];
}

class GameTotalOdds extends Equatable {
  final GameTotalOddsDetail open;
  final GameTotalOddsDetail current;

  GameTotalOdds({
    this.open,
    this.current,
  });

  factory GameTotalOdds.fromJson(Map<String, dynamic> json) {
    return GameTotalOdds(
      open: GameTotalOddsDetail.fromJson(json['open']),
      current: GameTotalOddsDetail.fromJson(json['current']),
    );
  }

  @override
  List<Object> get props => [open, current];
}

class GameTotalOddsDetail extends Equatable {
  final double total;
  final int overOdds;
  final int underOdds;

  GameTotalOddsDetail({
    this.total,
    this.overOdds,
    this.underOdds,
  });

  factory GameTotalOddsDetail.fromJson(Map<String, dynamic> json) {
    return GameTotalOddsDetail(
      total: json['total'].toDouble(),
      overOdds: json['overOdds'],
      underOdds: json['underOdds'],
    );
  }

  @override
  List<Object> get props => [total, overOdds, underOdds];
}
