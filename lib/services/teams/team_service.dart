import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/model/team.dart';
import 'package:voleizinho/services/groups/group_service.dart';
import 'package:voleizinho/services/teams/team_match/team_match_service.dart';
import 'package:voleizinho/services/user_preferences/user_preferences.dart';

class TeamService {
  static TeamService? _instance;

  static TeamService getInstance() {
    _instance ??= TeamService();
    return _instance!;
  }

  static get I => getInstance();

  final Map<int, List<Team>> _teams = {};

  _saveTeams(List<Team> teams) async {
    int groupId = GroupService.I.activeGroup().id;
    _teams[groupId] = teams;
    await UserPreferences.setTeams(groupId, teams);
  }

  Future<void> loadStoredTeams(List<int> groupIds) async {
    for (var groupId in groupIds) {
      _teams[groupId] = await UserPreferences.getTeams(groupId);
    }
  }

  List<Team> getTeams() {
    int groupId = GroupService.I.activeGroup().id;
    List<Team> groupTeams = [];
    if (_teams.containsKey(groupId)) {
      groupTeams = _teams[groupId]!;
    }
    return groupTeams;
  }

  void createTeams(List<Player> players, int playersPerTeam) {
    List<Team> teams = TeamMatchService.createTeams(players, playersPerTeam);
    _saveTeams(teams);
  }

  List<Player> getSimilarPlayers(Player player) {
    List<Team> teams = getTeams();
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

  void swapPlayers(Player player1, Player player2) {
    List<Team> teams = getTeams();
    for (var team in teams) {
      if (team.players.contains(player1)) {
        team.players.remove(player1);
        team.players.add(player2);
      } else if (team.players.contains(player2)) {
        team.players.remove(player2);
        team.players.add(player1);
      }
    }
    _saveTeams(teams);
  }

  double avgDiffOnSwap(Player player1, Player player2) {
    List<Team> teams = getTeams();
    Team team =
        teams.firstWhere((element) => element.players.contains(player1));
    return (player2.getAverage() - player1.getAverage()) / team.players.length;
  }
}
