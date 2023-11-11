import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voleizinho/bloc/players/players_events.dart';
import 'package:voleizinho/bloc/players/players_states.dart';
import 'package:voleizinho/services/player_service.dart';

class PlayersBloc extends Bloc<PlayersEvent, PlayersState> {
  final PlayerService playerService;

  PlayersBloc(this.playerService) : super(PlayersState(players: [])) {
    on<PlayersLoadEvent>(_onLoadPlayers);
    on<PlayersCreateEvent>(_onCreatePlayer);
    on<PlayersEditingEvent>(_onEditingPlayer);
    on<PlayersEditEvent>(_onEditPlayer);
    on<PlayersDeletingEvent>(_onDeletingPlayer);
    on<PlayersDeleteEvent>(_onDeletePlayer);
    on<PlayersImportEvent>(_onImportPlayers);
    on<PlayersExportEvent>(_onExportPlayers);
    on<PlayersClearEvent>(_onClearPlayers);
  }

  void _onLoadPlayers(PlayersLoadEvent event, Emitter<PlayersState> emit) {
    emit(state.copyWith(
        players: playerService.getPlayersFromGroup(event.groupId)));
  }

  void _onCreatePlayer(
      PlayersCreateEvent event, Emitter<PlayersState> emit) async {
    if (event.player.name == null || event.player.name!.isEmpty) {
      emit(state.copyWith(
          isError: true,
          errorMessage: "O nome do jogador não pode estar vazio!"));
      emit(state.copyWith(isError: false, errorMessage: ""));
      return;
    }
    event.player.groupId = event.player.groupId;
    playerService.addPlayer(event.player, event.player.groupId);
    emit(state.copyWith(
        players: playerService.getPlayersFromGroup(event.player.groupId),
        editingPlayerIndex: -2));
  }

  void _onEditingPlayer(PlayersEditingEvent event, Emitter<PlayersState> emit) {
    emit(state.copyWith(
        editingPlayerIndex: event.index, deletingPlayerIndex: -2));
  }

  void _onDeletingPlayer(
      PlayersDeletingEvent event, Emitter<PlayersState> emit) {
    emit(state.copyWith(
        deletingPlayerIndex: event.index, editingPlayerIndex: -2));
  }

  void _onEditPlayer(PlayersEditEvent event, Emitter<PlayersState> emit) async {
    if (event.player.name == -2 || event.player.name!.isEmpty) {
      emit(
        state.copyWith(
            isError: true,
            errorMessage: "O nome do jogador não pode estar vazio!"),
      );
      emit(state.copyWith(isError: false, errorMessage: ""));
      return;
    }
    playerService.updatePlayer(event.player);
    emit(state.copyWith(
        players: playerService.getPlayersFromGroup(event.player.groupId),
        editingPlayerIndex: -2));
  }

  void _onDeletePlayer(PlayersDeleteEvent event, Emitter<PlayersState> emit) {
    playerService.deletePlayer(event.player);
    emit(state.copyWith(
        players: playerService.getPlayersFromGroup(event.player.groupId),
        deletingPlayerIndex: -2));
  }

  void _onImportPlayers(
      PlayersImportEvent event, Emitter<PlayersState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    int groupId = prefs.getInt("activeGroup") ?? 0;
    await playerService.importPlayersList(groupId);
    emit(state.copyWith(players: playerService.getPlayersFromGroup(groupId)));
  }

  void _onExportPlayers(
      PlayersExportEvent event, Emitter<PlayersState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    int groupId = prefs.getInt("activeGroup") ?? 0;
    await playerService.exportPlayersList(groupId);
  }

  void _onClearPlayers(
      PlayersClearEvent event, Emitter<PlayersState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    int groupId = prefs.getInt("activeGroup") ?? 0;
    playerService.removePlayersFromGroup(groupId);
    emit(state.copyWith(players: playerService.getPlayersFromGroup(groupId)));
  }
}
