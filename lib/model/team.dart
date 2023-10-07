import 'package:voleizinho/model/player.dart';

class Team {
  Team() {
    players = [];
  }

  List<Player> players = [];

  double getAverage() {
    double sum = 0;
    for (var player in players) {
      sum += player.getAverage();
    }

    return sum / players.length;
  }

  void addPlayer(Player player) {
    players.add(player);
  }

  void removePlayer(Player player) {
    players.remove(player);
  }

  List<Player> getPlayers() {
    return players;
  }

  Map<String, dynamic> toJson() {
    return {
      'players': players.map((e) => e.toJson()).toList(),
    };
  }

  Team.fromJson(Map<String, dynamic> json) {
    players = json['players']
        .map<Player>((e) => Player.fromJson(e))
        .toList()
        .cast<Player>();
  }
}
