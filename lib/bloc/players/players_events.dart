import 'package:voleizinho/model/player.dart';

abstract class PlayersEvent {}

class PlayersLoadEvent extends PlayersEvent {
  final int groupId;

  PlayersLoadEvent(this.groupId);
}

class PlayersCreateEvent extends PlayersEvent {
  final Player player;

  PlayersCreateEvent(this.player);
}

class PlayersEditingEvent extends PlayersEvent {
  final int index;

  PlayersEditingEvent(this.index);
}

class PlayersEditEvent extends PlayersEvent {
  final Player player;
  final int index;

  PlayersEditEvent(this.player, this.index);
}

class PlayersDeletingEvent extends PlayersEvent {
  final int? index;

  PlayersDeletingEvent(this.index);
}

class PlayersDeleteEvent extends PlayersEvent {
  final Player player;

  PlayersDeleteEvent(this.player);
}

class PlayersImportEvent extends PlayersEvent {
  final int groupId;

  PlayersImportEvent(this.groupId);
}

class PlayersExportEvent extends PlayersEvent {
  final int groupId;

  PlayersExportEvent(this.groupId);
}

class PlayersClearEvent extends PlayersEvent {
  final int groupId;

  PlayersClearEvent(this.groupId);
}
