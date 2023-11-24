import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/model/team.dart';

enum TeamsStatus { initial, loading, loaded, error, created }

class TeamsState {
  final TeamsStatus status;
  final String? errorMessage;
  final List<Team> teams;
  final List<Player> selectedPlayers;
  final bool usePositionalBalancing;
  final Map<Player, List<Player>> similarPlayers;

  const TeamsState({
    this.status = TeamsStatus.initial,
    this.errorMessage,
    this.teams = const [],
    this.selectedPlayers = const [],
    this.usePositionalBalancing = false,
    this.similarPlayers = const {},
  });

  TeamsState copyWith({
    TeamsStatus? status,
    String? errorMessage,
    List<Team>? teams,
    List<Player>? selectedPlayers,
    bool? usePositionalBalancing,
    Map<Player, List<Player>>? similarPlayers,
  }) {
    return TeamsState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      teams: teams ?? this.teams,
      selectedPlayers: selectedPlayers ?? this.selectedPlayers,
      usePositionalBalancing:
          usePositionalBalancing ?? this.usePositionalBalancing,
      similarPlayers: similarPlayers ?? this.similarPlayers,
    );
  }
}
