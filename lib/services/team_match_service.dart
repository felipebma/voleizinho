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
    shuffleTeams();

    if (undraftedPlayers.isNotEmpty) {
      Team undraftedTeam = Team();
      for (var player in undraftedPlayers) {
        undraftedTeam.addPlayer(player);
      }
      teams.add(undraftedTeam);
    }
    for (int i = 0; i < 6; i++) {
      for (int i = 0; i < teams.length; i++) {
        for (int j = i + 1; j < teams.length; j++) {
          balanceTeams(teams[i], teams[j]);
        }
      }
    }
    return teams;
  }

  static void balanceTeams(Team team1, Team team2) {
    List<Player> bestPair = [];
    double bestDiff = (team1.getAverage() - team2.getAverage()).abs();
    for (Player p1 in [...team1.players]) {
      for (Player p2 in [...team2.players]) {
        double avg1 = p2.getAverage();
        for (Player p in team1.players) {
          if (p != p1) {
            avg1 += p.getAverage();
          }
        }
        avg1 /= team1.players.length;
        double avg2 = p1.getAverage();
        for (Player p in team2.players) {
          if (p != p2) {
            avg2 += p.getAverage();
          }
        }
        avg2 /= team1.players.length;
        double diff = (avg1 - avg2).abs();
        if (diff < bestDiff) {
          bestDiff = diff;
          bestPair = [p1, p2];
        }
      }
    }
    if (bestPair.isNotEmpty) {
      swapPlayers(bestPair[0], bestPair[1]);
    }
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
      if (!team.players.contains(player)) {
        players.addAll(team.players);
      }
    }
    players
        .sort((a, b) => player.similarity(b).compareTo(player.similarity(a)));
    return players;
  }

  static void swapPlayersInTeams(
      Team team1, Player player1, Team team2, Player player2) {
    team1.players.remove(player1);
    team1.players.add(player2);
    team2.players.remove(player2);
    team2.players.add(player1);
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
