import 'package:voleizinho/model/player.dart';

class Team {
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
}
