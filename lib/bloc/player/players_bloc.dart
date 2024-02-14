import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:voleizinho/bloc/player/players_event.dart';
import 'package:voleizinho/bloc/player/players_state.dart';
import 'package:voleizinho/exceptions/player/player_name_already_existis_exception.dart';
import 'package:voleizinho/exceptions/player/player_name_is_empty_exception.dart';
import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/services/players/player_service.dart';

class PlayersBloc extends Bloc<PlayersEvent, PlayersState> {
  final PlayerService playerService = GetIt.I<PlayerService>();

  PlayersBloc() : super(PlayersState.initial()) {
    on<PlayersLoadEvent>(_onPlayersLoadEvent);
    on<CreatePlayerEvent>(_onCreatePlayerEvent);
    on<EditPlayerEvent>(_onEditPlayerEvent);
    on<DeletePlayerEvent>(_onDeletePlayerEvent);
    on<ImportPlayersEvent>(_onImportPlayersEvent);
    on<ExportPlayersEvent>(_onExportPlayersEvent);
    on<DeleteAllPlayersEvent>(_onDeleteAllPlayersEvent);
  }

  void _onPlayersLoadEvent(
      PlayersLoadEvent event, Emitter<PlayersState> emit) async {
    emit(state.copyWith(status: PlayersStatus.loading));
    try {
      List<Player> players = playerService.getPlayersFromGroup(event.groupId);
      emit(state.copyWith(
          status: PlayersStatus.loaded, players: players, errorMessage: null));
    } catch (e) {
      emit(
        state.copyWith(
          status: PlayersStatus.error,
          players: [],
          errorMessage:
              "Ocorreu um erro, não foi possível carregar os jogadores!",
        ),
      );
    }
  }

  void _onCreatePlayerEvent(
      CreatePlayerEvent event, Emitter<PlayersState> emit) async {
    try {
      playerService.addPlayer(event.player);
      List<Player> players =
          playerService.getPlayersFromGroup(event.player.groupId);
      emit(state.copyWith(
          status: PlayersStatus.created, players: players, errorMessage: null));
    } on PlayerNameAlreadyExistsException {
      emit(
        state.copyWith(
          status: PlayersStatus.error,
          errorMessage: "Já existe outro jogador com esse nome!",
        ),
      );
    } on PlayerNameIsEmptyException {
      emit(
        state.copyWith(
          status: PlayersStatus.error,
          errorMessage: "O nome do jogador não pode ser vazio!",
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PlayersStatus.error,
          errorMessage: "Ocorreu um erro, não foi possível criar o jogador!",
        ),
      );
    }
  }

  void _onEditPlayerEvent(
      EditPlayerEvent event, Emitter<PlayersState> emit) async {
    try {
      playerService.updatePlayer(event.player);
      List<Player> players =
          playerService.getPlayersFromGroup(event.player.groupId);
      emit(state.copyWith(
          status: PlayersStatus.edited, players: players, errorMessage: null));
    } on PlayerNameAlreadyExistsException {
      emit(
        state.copyWith(
          status: PlayersStatus.error,
          players: [],
          errorMessage: "Já existe outro jogador com esse nome!",
        ),
      );
    } on PlayerNameIsEmptyException {
      emit(
        state.copyWith(
          status: PlayersStatus.error,
          players: [],
          errorMessage: "O nome do jogador não pode ser vazio!",
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PlayersStatus.error,
          players: [],
          errorMessage: "Ocorreu um erro, não foi possível editar o jogador!",
        ),
      );
    }
  }

  void _onDeletePlayerEvent(
      DeletePlayerEvent event, Emitter<PlayersState> emit) async {
    try {
      playerService.removePlayer(event.player);
      List<Player> players =
          playerService.getPlayersFromGroup(event.player.groupId);
      emit(state.copyWith(
          status: PlayersStatus.deleted, players: players, errorMessage: null));
    } catch (e) {
      emit(
        state.copyWith(
          status: PlayersStatus.error,
          players: [],
          errorMessage: "Ocorreu um erro, não foi possível deletar o jogador!",
        ),
      );
    }
  }

  void _onImportPlayersEvent(
      ImportPlayersEvent event, Emitter<PlayersState> emit) async {
    try {
      emit(state.copyWith(status: PlayersStatus.loading));
      await playerService.importPlayersList(event.groupId);
      List<Player> players = playerService.getPlayersFromGroup(event.groupId);
      emit(state.copyWith(
          status: PlayersStatus.loaded, players: players, errorMessage: null));
    } catch (e) {
      emit(
        state.copyWith(
          status: PlayersStatus.error,
          players: [],
          errorMessage:
              "Ocorreu um erro, não foi possível importar os jogadores!",
        ),
      );
    }
  }

  void _onExportPlayersEvent(
      ExportPlayersEvent event, Emitter<PlayersState> emit) async {
    try {
      playerService.exportPlayersList(event.groupId);
      List<Player> players = playerService.getPlayersFromGroup(event.groupId);
      emit(state.copyWith(
          status: PlayersStatus.loaded, players: players, errorMessage: null));
    } catch (e) {
      emit(
        state.copyWith(
          status: PlayersStatus.error,
          players: [],
          errorMessage:
              "Ocorreu um erro, não foi possível exportar os jogadores!",
        ),
      );
    }
  }

  void _onDeleteAllPlayersEvent(
      DeleteAllPlayersEvent event, Emitter<PlayersState> emit) async {
    try {
      playerService.removePlayersFromGroup(event.groupId);
      List<Player> players = playerService.getPlayersFromGroup(event.groupId);
      emit(state.copyWith(
          status: PlayersStatus.loaded, players: players, errorMessage: null));
    } catch (e) {
      emit(
        state.copyWith(
          status: PlayersStatus.error,
          players: [],
          errorMessage:
              "Ocorreu um erro, não foi possível deletar os jogadores!",
        ),
      );
    }
  }
}
