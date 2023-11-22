import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/model/team.dart';
import 'package:voleizinho/services/group_service.dart';

class TeamMatchService {
  static List<Team> createTeams(List<Player> players, int playersPerTeam) {
    List<Team> teams = [];
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
    _shuffleTeams(teams);

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
            balanceTeams(teams[i], teams[j]);
          }
        }
      }
    }
    return teams;
  }

  static void balanceTeams(Team team1, Team team2) {
    if (GroupService.I.activeGroup().usePositionalBalancing) {
      _balanceTeamsPositional(team1, team2);
    } else {
      _balanceTeamsLegacy(team1, team2);
    }
  }

  static void _balanceTeamsLegacy(Team team1, Team team2) {
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
        avg2 /= team2.players.length;
        double diff = (avg1 - avg2).abs();
        if (diff < bestDiff) {
          bestDiff = diff;
          bestPair = [p1, p2];
        }
      }
    }
    if (bestPair.isNotEmpty) {
      _swapPlayers(team1, team2, bestPair[0], bestPair[1]);
    }
  }

  static void _balanceTeamsPositional(Team team1, Team team2) {
    List<Player> bestPair = [];
    double bestDiff = team1.getDifference(team2);
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
        double diff = t1.getDifference(t2);
        if (diff < bestDiff) {
          bestDiff = diff;
          bestPair = [p1, p2];
        }
      }
    }
    if (bestPair.isNotEmpty) {
      _swapPlayers(team1, team2, bestPair[0], bestPair[1]);
    }
  }

  static void _swapPlayers(
      Team team1, Team team2, Player player1, Player player2) {
    team1.removePlayer(player1);
    team1.addPlayer(player2);
    team2.removePlayer(player2);
    team2.addPlayer(player1);
  }

  static void _shuffleTeams(List<Team> teams) {
    teams.shuffle();
    for (var team in teams) {
      team.players.shuffle();
    }
  }
}
