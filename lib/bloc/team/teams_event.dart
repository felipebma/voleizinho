import 'package:voleizinho/model/player.dart';

class TeamsEvent {}

class LoadTeams extends TeamsEvent {
  final int groupId;

  LoadTeams(this.groupId);
}

class CreateTeams extends TeamsEvent {
  final int groupId;

  CreateTeams(this.groupId);
}

class SetPlayersPerTeam extends TeamsEvent {
  final int playersPerTeam;

  SetPlayersPerTeam(this.playersPerTeam);
}

class LoadSelectedPlayers extends TeamsEvent {
  final int groupId;

  LoadSelectedPlayers(this.groupId);
}

class SelectPlayer extends TeamsEvent {
  final Player player;

  SelectPlayer(this.player);
}

class UnselectAllPlayers extends TeamsEvent {}

class SwapPlayers extends TeamsEvent {
  final int groupId;
  final Player player1;
  final Player player2;

  SwapPlayers(this.groupId, this.player1, this.player2);
}

class GetSimilarPlayers extends TeamsEvent {
  final Player player;

  GetSimilarPlayers(this.player);
}
