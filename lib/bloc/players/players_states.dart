import 'package:voleizinho/model/player.dart';

class PlayersState {
  List<Player> players;
  int editingPlayerIndex;
  int deletingPlayerIndex;
  bool isError;
  String? errorMessage;

  PlayersState(
      {required this.players,
      this.editingPlayerIndex = -2,
      this.deletingPlayerIndex = -2,
      this.isError = false,
      this.errorMessage});

  PlayersState copyWith(
      {List<Player>? players,
      int? editingPlayerIndex,
      int? deletingPlayerIndex,
      bool? isError,
      String? errorMessage}) {
    return PlayersState(
      players: players ?? this.players,
      editingPlayerIndex: editingPlayerIndex ?? this.editingPlayerIndex,
      deletingPlayerIndex: deletingPlayerIndex ?? this.deletingPlayerIndex,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
