import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/model/skills.dart';
import 'package:voleizinho/model/team.dart';

class TeamMatchService {
  static Map<Skill, int> skillWeights = {};
  static List<Team> teams = [];

  static List<Team> getTeams() {
    return teams;
  }

  static List<Team> createTeams(List<Player> players, int playersPerTeam) {
    teams = [];
    List<Player> undraftedPlayers = [...players];
    undraftedPlayers.sort((a, b) => b.getAverage().compareTo(a.getAverage()));
    int numOfTeams = players.length ~/ playersPerTeam;
    for (int i = 0; i < numOfTeams; i++) {
      teams.add(Team());
    }
    for (int i = 0; i < playersPerTeam - 1; i += 2) {
      for (int j = 0; j < numOfTeams; j++) {
        teams[j].addPlayer(undraftedPlayers.removeAt(0));
      }
      for (int j = numOfTeams - 1; j >= 0; j--) {
        teams[j].addPlayer(undraftedPlayers.removeAt(0));
      }
    }
    if (playersPerTeam % 2 == 1) {
      for (int j = numOfTeams - 1; j >= 0; j--) {
        teams[j].addPlayer(undraftedPlayers.removeAt(0));
      }
    }

    if (undraftedPlayers.isNotEmpty) {
      Team undraftedTeam = Team();
      for (var player in undraftedPlayers) {
        undraftedTeam.addPlayer(player);
      }
      teams.add(undraftedTeam);
    }
    shuffleTeams();
    return teams;
  }

  static void shuffleTeams() {
    teams.shuffle();
    for (var team in teams) {
      team.players.shuffle();
    }
  }

  static List<Player> getSimilarPlayers(Player player) {
    List<Player> players = [];
    for (var team in teams) {
      print("entrou");
      if (!team.players.contains(player)) {
        players.addAll(team.players);
      }
    }
    print(players.length);
    players
        .sort((a, b) => player.similarity(b).compareTo(player.similarity(a)));
    return players;
  }

  static void swapPlayers(Player player1, Player player2) {
    for (var team in teams) {
      if (team.players.contains(player1)) {
        team.players.remove(player1);
        team.players.add(player2);
      } else if (team.players.contains(player2)) {
        team.players.remove(player2);
        team.players.add(player1);
      }
    }
  }

  static double avgDiffOnSwap(Player player1, Player player2) {
    double avgDiff = 0;
    for (var team in teams) {
      Team team_copy = Team();
      team_copy.players = [...team.players];
      if (team.players.contains(player1)) {
        team_copy.players.remove(player1);
        team_copy.players.add(player2);
        avgDiff = team_copy.getAverage();
        team_copy.players.remove(player2);
        team_copy.players.add(player1);
        avgDiff -= team_copy.getAverage();
      }
    }
    return avgDiff;
  }
}
