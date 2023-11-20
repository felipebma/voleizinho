import 'package:voleizinho/model/player.dart';

enum PlayersStatus { initial, loading, loaded, error }

class PlayersState {
  PlayersStatus status;
  List<Player> players;
  String? errorMessage;

  PlayersState(
      {required this.status, required this.players, this.errorMessage});

  factory PlayersState.initial() =>
      PlayersState(status: PlayersStatus.initial, players: []);

  PlayersState copyWith(
      {PlayersStatus? status, List<Player>? players, String? errorMessage}) {
    return PlayersState(
        status: status ?? this.status,
        players: players ?? this.players,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
