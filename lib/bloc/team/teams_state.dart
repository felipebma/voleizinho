import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/model/similar_player.dart';
import 'package:voleizinho/model/team.dart';

enum TeamsStatus {
  initial,
  loading,
  loaded,
  error,
  created,
  playersSelected,
  playersUnselected,
  playersSwapped,
  similarPlayersLoaded,
  playersPerTeamSet,
}

class TeamsState {
  final TeamsStatus status;
  final String? errorMessage;
  final List<Team> teams;
  final List<Player> selectedPlayers;
  final bool usePositionalBalancing;
  final List<SimilarPlayer> similarPlayers;

  final int playersPerTeam;
  final int minPlayersPerTeam;
  final int maxPlayersPerTeam;

  const TeamsState({
    this.status = TeamsStatus.initial,
    this.errorMessage,
    this.teams = const [],
    this.selectedPlayers = const [],
    this.usePositionalBalancing = false,
    this.similarPlayers = const [],
    this.playersPerTeam = 0,
    this.minPlayersPerTeam = 0,
    this.maxPlayersPerTeam = 0,
  });

  TeamsState copyWith({
    TeamsStatus? status,
    String? errorMessage,
    List<Team>? teams,
    List<Player>? selectedPlayers,
    bool? usePositionalBalancing,
    List<SimilarPlayer>? similarPlayers,
    int? playersPerTeam,
    int? minPlayersPerTeam,
    int? maxPlayersPerTeam,
  }) {
    return TeamsState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      teams: teams ?? this.teams,
      selectedPlayers: selectedPlayers ?? this.selectedPlayers,
      usePositionalBalancing:
          usePositionalBalancing ?? this.usePositionalBalancing,
      similarPlayers: similarPlayers ?? this.similarPlayers,
      playersPerTeam: playersPerTeam ?? this.playersPerTeam,
      minPlayersPerTeam: minPlayersPerTeam ?? this.minPlayersPerTeam,
      maxPlayersPerTeam: maxPlayersPerTeam ?? this.maxPlayersPerTeam,
    );
  }
}
