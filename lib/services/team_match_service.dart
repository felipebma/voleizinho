import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/model/skills.dart';
import 'package:voleizinho/model/team.dart';
import 'package:voleizinho/services/user_preferences.dart';

class TeamMatchService {
  static List<Team> teams = [];

  static List<Team> getTeams() {
    return teams;
  }

  static Future<void> loadStoredTeams() async {
    teams = await UserPreferences.getTeams();
  }

  static Future<void> createTeams(List<Player> players, int playersPerTeam,
      Map<Skill, int> skillsWeights, bool usePositionalBalancing) async {
    teams = [];
    List<Player> undraftedPlayers = [...players];
    undraftedPlayers.sort((a, b) =>
        b.getAverage(skillsWeights).compareTo(a.getAverage(skillsWeights)));
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
        for (int j = 0; j < teams.length; j++) {
          if (i != j) {
            balanceTeams(
                teams[i], teams[j], skillsWeights, usePositionalBalancing);
          }
        }
      }
    }
    await UserPreferences.setTeams(teams);
  }

  static void balanceTeams(Team team1, Team team2,
      Map<Skill, int> skillsWeights, bool usePositionalBalacing) {
    if (usePositionalBalacing) {
      balanceTeamsPositional(team1, team2, skillsWeights);
    } else {
      balanceTeamsLegacy(team1, team2, skillsWeights);
    }
  }

  static void balanceTeamsLegacy(
      Team team1, Team team2, Map<Skill, int> skillsWeights) {
    List<Player> bestPair = [];
    double bestDiff =
        (team1.getAverage(skillsWeights) - team2.getAverage(skillsWeights))
            .abs();
    for (Player p1 in [...team1.players]) {
      for (Player p2 in [...team2.players]) {
        double avg1 = p2.getAverage(skillsWeights);
        for (Player p in team1.players) {
          if (p != p1) {
            avg1 += p.getAverage(skillsWeights);
          }
        }
        avg1 /= team1.players.length;
        double avg2 = p1.getAverage(skillsWeights);
        for (Player p in team2.players) {
          if (p != p2) {
            avg2 += p.getAverage(skillsWeights);
          }
        }
        avg2 /= team2.players.length;
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

  static void balanceTeamsPositional(
      Team team1, Team team2, Map<Skill, int> skillsWeights) {
    List<Player> bestPair = [];
    double bestDiff = team1.getDifference(team2, skillsWeights);
    for (Player p1 in [...team1.players]) {
      for (Player p2 in [...team2.players]) {
        Team t1 = Team();
        t1.addPlayer(p2.copyWith());
        for (Player p in team1.players) {
          if (p != p1) {
            t1.addPlayer(p.copyWith());
          }
        }
        Team t2 = Team();
        t2.addPlayer(p1.copyWith());
        for (Player p in team2.players) {
          if (p != p2) {
            t2.addPlayer(p.copyWith());
          }
        }
        double diff = t1.getDifference(t2, skillsWeights);
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

  static List<Player> getSimilarPlayers(
      Player player, Map<Skill, int> skillsWeights) {
    List<Player> players = [];
    for (var team in teams) {
      if (!team.players.contains(player)) {
        players.addAll(team.players);
      }
    }
    players.sort((a, b) => player
        .similarity(b, skillsWeights)
        .compareTo(player.similarity(a, skillsWeights)));
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

  static double avgDiffOnSwap(
      Player player1, Player player2, Map<Skill, int> skillsWeights) {
    double avgDiff = 0;
    for (var team in teams) {
      Team teamCopy = Team();
      teamCopy.players = [...team.players];
      if (team.players.contains(player1)) {
        teamCopy.players.remove(player1);
        teamCopy.players.add(player2);
        avgDiff = teamCopy.getAverage(skillsWeights);
        teamCopy.players.remove(player2);
        teamCopy.players.add(player1);
        avgDiff -= teamCopy.getAverage(skillsWeights);
      }
    }
    return avgDiff;
  }
}
