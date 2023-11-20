import 'package:voleizinho/model/player.dart';

abstract class PlayersEvent {}

class PlayersLoadEvent extends PlayersEvent {
  final int groupId;

  PlayersLoadEvent(this.groupId);
}

class CreatePlayerEvent extends PlayersEvent {
  final Player player;

  CreatePlayerEvent(this.player);
}

class EditPlayerEvent extends PlayersEvent {
  final Player player;

  EditPlayerEvent(this.player);
}

class DeletePlayerEvent extends PlayersEvent {
  final Player player;

  DeletePlayerEvent(this.player);
}

class ImportPlayersEvent extends PlayersEvent {
  final int groupId;

  ImportPlayersEvent(this.groupId);
}

class ExportPlayersEvent extends PlayersEvent {
  final int groupId;

  ExportPlayersEvent(this.groupId);
}

class DeleteAllPlayersEvent extends PlayersEvent {
  final int groupId;

  DeleteAllPlayersEvent(this.groupId);
}
