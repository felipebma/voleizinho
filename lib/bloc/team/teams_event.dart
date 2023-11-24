import 'package:voleizinho/model/player.dart';

class TeamsEvent {}

class LoadTeams extends TeamsEvent {}

class CreateTeams extends TeamsEvent {
  final List<Player> players;
  final int playersPerTeam;
  final bool usePositionalBalancing;

  CreateTeams(this.players, this.playersPerTeam, this.usePositionalBalancing);
}

class SelectPlayer extends TeamsEvent {
  final Player player;

  SelectPlayer(this.player);
}

class SwapPlayers extends TeamsEvent {
  final Player player1;
  final Player player2;

  SwapPlayers(this.player1, this.player2);
}

class GetSimilarPlayers extends TeamsEvent {
  final Player player;

  GetSimilarPlayers(this.player);
}
