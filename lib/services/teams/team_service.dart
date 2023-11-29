import 'package:voleizinho/exceptions/team/not_enough_players_exception.dart';
import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/model/team.dart';
import 'package:voleizinho/services/teams/team_match/team_match_service.dart';
import 'package:voleizinho/services/user_preferences/user_preferences.dart';

class TeamService {
  static TeamService? _instance;
  final int minPlayersPerTeam = 2;

  static TeamService getInstance() {
    _instance ??= TeamService();
    return _instance!;
  }

  static get I => getInstance();

  _saveTeams(List<Team> teams, int groupId) async {
    await UserPreferences.setTeams(groupId, teams);
  }

  Future<List<Team>> getTeams(int groupId) async {
    return await UserPreferences.getTeams(groupId);
  }

  Future<void> createTeams(int groupId, List<Player> players,
      int playersPerTeam, bool usePositionalBalancing) async {
    if (players.length < 2 * playersPerTeam ||
        playersPerTeam < minPlayersPerTeam) {
      throw NotEnoughPlayersException("Not enough players to create teams");
    }
    List<Team> teams = TeamMatchService.createTeams(
        players, playersPerTeam, usePositionalBalancing);
    await _saveTeams(teams, groupId);
  }

  List<Player> getSimilarPlayers(List<Team> teams, Player player) {
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

  void swapPlayers(
      int groupId, List<Team> teams, Player player1, Player player2) async {
    for (var team in teams) {
      if (team.players.contains(player1)) {
        team.players.remove(player1);
        team.players.add(player2);
      } else if (team.players.contains(player2)) {
        team.players.remove(player2);
        team.players.add(player1);
      }
    }
    await _saveTeams(teams, groupId);
  }

  double avgDiffOnSwap(List<Team> teams, Player player1, Player player2) {
    Team team =
        teams.firstWhere((element) => element.players.contains(player1));
    return (player2.getAverage() - player1.getAverage()) / team.players.length;
  }
}
