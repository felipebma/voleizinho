import 'package:voleizinho/model/player.dart';

class TeamsEvent {}

class LoadTeams extends TeamsEvent {
  final int groupId;

  LoadTeams(this.groupId);
}

class CreateTeams extends TeamsEvent {
  final int groupId;
  final List<Player> players;
  final int playersPerTeam;

  CreateTeams(this.groupId, this.players, this.playersPerTeam);
}

class SelectPlayer extends TeamsEvent {
  final Player player;

  SelectPlayer(this.player);
}

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
