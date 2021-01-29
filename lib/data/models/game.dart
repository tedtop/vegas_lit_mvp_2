import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

const String jsonAssetPath = 'assets/json/games.json';
const String apiEndpoint = 'https://rapidapi.p.rapidapi.com/games';
const String rapidApiHost = 'sportspage-feeds.p.rapidapi.com';
const String rapidApiKey = 'API_KEY';

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

  @override
  List<Object> get props => [];

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
    return parsed.map<Game>((json) => Game.fromJson(json)).toList();
  }

  // static Future<List<Game>> fetchAllFromApi() async {
  //   Map<String, String> headers = {
  //     'x-rapidapi-host': rapidApiHost,
  //     'x-rapidapi-key': rapidApiKey,
  //   };

  //   Response response = await get(apiEndpoint, headers: headers);

  //   if (response.statusCode == 200) {
  //     List<dynamic> parsed = json.decode(response.body)['results'];
  //     return parsed.map<Game>((json) => Game.fromJson(json)).toList();
  //   } else {
  //     throw response.body;
  //   }
  // }
}

class GameSchedule {
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
}

class GameDetails {
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
}

class GameTeams {
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
}

class GameTeam {
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
}

class GameVenue {
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
}

class GameOdds {
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
}

class GameSpreadOdds {
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
}

class GameSpreadOddsDetail {
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
}

class GameMoneylineOdds {
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
}

class GameMoneylineOddsDetail {
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
}

class GameTotalOdds {
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
}

class GameTotalOddsDetail {
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
}
