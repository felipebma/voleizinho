import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:voleizinho/bloc/team/teams_event.dart';
import 'package:voleizinho/bloc/team/teams_state.dart';
import 'package:voleizinho/exceptions/team/not_enough_players_exception.dart';
import 'package:voleizinho/model/group.dart';
import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/model/similar_player.dart';
import 'package:voleizinho/model/team.dart';
import 'package:voleizinho/services/groups/group_service.dart';
import 'package:voleizinho/services/teams/team_service.dart';

class TeamsBloc extends Bloc<TeamsEvent, TeamsState> {
  final TeamService teamsService = TeamService.getInstance();
  final GroupService groupService = GetIt.I<GroupService>();

  TeamsBloc() : super(const TeamsState()) {
    on<LoadTeams>(_getTeams);
    on<CreateTeams>(_createTeams);
    on<LoadSelectedPlayers>(_loadSelectedPlayers);
    on<SetPlayersPerTeam>((event, emit) {
      emit(state.copyWith(
          status: TeamsStatus.playersPerTeamSet,
          playersPerTeam: event.playersPerTeam));
    });
    on<SelectPlayer>(_selectPlayer);
    on<UnselectAllPlayers>(_unselectAllPlayers);
    on<SwapPlayers>(_swapPlayers);
    on<SelectPlayerToSwitch>(_selectPlayerToSwitch);
  }

  Future<void> _getTeams(
    LoadTeams event,
    Emitter<TeamsState> emit,
  ) async {
    emit(state.copyWith(status: TeamsStatus.loading));
    try {
      final teams = await teamsService.getTeams(event.groupId);
      emit(state.copyWith(status: TeamsStatus.loaded, teams: teams));
    } catch (e) {
      emit(state.copyWith(
          status: TeamsStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _createTeams(
    CreateTeams event,
    Emitter<TeamsState> emit,
  ) async {
    emit(state.copyWith(status: TeamsStatus.loading));
    try {
      Group group = groupService.getGroupById(event.groupId);
      bool usePositionalBalancing = group.usePositionalBalancing;
      await teamsService.createTeams(event.groupId, state.selectedPlayers,
          state.playersPerTeam, usePositionalBalancing);
      final teams = await teamsService.getTeams(event.groupId);
      emit(state.copyWith(status: TeamsStatus.created, teams: teams));
    } on NotEnoughPlayersException {
      emit(state.copyWith(
          status: TeamsStatus.error,
          errorMessage:
              "Você deve selecionar pelo menos 2 jogadores por time!"));
    } catch (e) {
      emit(state.copyWith(
          status: TeamsStatus.error, errorMessage: e.toString()));
    }
  }

  void _loadSelectedPlayers(
    LoadSelectedPlayers event,
    Emitter<TeamsState> emit,
  ) async {
    emit(state.copyWith(status: TeamsStatus.loading));
    List<Player> selectedPlayers = (await teamsService.getTeams(event.groupId))
        .map((team) => team.players)
        .expand((element) => element)
        .toList();
    int minPlayersPerTeam = min(selectedPlayers.length ~/ 2, 2);
    int maxPlayersPerTeam = selectedPlayers.length ~/ 2;
    int playersPerTeam = state.playersPerTeam;
    if (playersPerTeam < minPlayersPerTeam) {
      playersPerTeam = min(selectedPlayers.length ~/ 2, 2);
    }
    if (playersPerTeam > maxPlayersPerTeam) {
      playersPerTeam = maxPlayersPerTeam;
    }
    emit(
      state.copyWith(
        status: TeamsStatus.playersSelected,
        selectedPlayers: selectedPlayers,
        playersPerTeam: playersPerTeam,
        minPlayersPerTeam: minPlayersPerTeam,
        maxPlayersPerTeam: maxPlayersPerTeam,
      ),
    );
  }

  void _selectPlayer(
    SelectPlayer event,
    Emitter<TeamsState> emit,
  ) {
    List<Player> selectedPlayers = state.selectedPlayers;
    if (selectedPlayers.any((player) => player.id == event.player.id)) {
      selectedPlayers.removeWhere((player) => player.id == event.player.id);
    } else {
      selectedPlayers.add(event.player);
    }
    int minPlayersPerTeam = min(selectedPlayers.length ~/ 2, 2);
    int maxPlayersPerTeam = selectedPlayers.length ~/ 2;
    int playersPerTeam = state.playersPerTeam;
    if (playersPerTeam < minPlayersPerTeam) {
      playersPerTeam = min(selectedPlayers.length ~/ 2, 2);
    }
    if (playersPerTeam > maxPlayersPerTeam) {
      playersPerTeam = maxPlayersPerTeam;
    }
    emit(
      state.copyWith(
        status: TeamsStatus.playersSelected,
        selectedPlayers: selectedPlayers,
        playersPerTeam: playersPerTeam,
        minPlayersPerTeam: minPlayersPerTeam,
        maxPlayersPerTeam: maxPlayersPerTeam,
      ),
    );
  }

  void _unselectAllPlayers(
    UnselectAllPlayers event,
    Emitter<TeamsState> emit,
  ) {
    emit(
      state.copyWith(
        status: TeamsStatus.playersUnselected,
        selectedPlayers: [],
        minPlayersPerTeam: 0,
        maxPlayersPerTeam: 0,
        playersPerTeam: 0,
      ),
    );
  }

  void _swapPlayers(
    SwapPlayers event,
    Emitter<TeamsState> emit,
  ) async {
    List<Team> teams = state.teams;
    teamsService.swapPlayers(
        event.groupId, teams, state.switchingPlayer!, event.player2);
    emit(
      state.copyWith(
        status: TeamsStatus.playersSwapped,
        teams: teams,
      ),
    );
  }

  void _selectPlayerToSwitch(
    SelectPlayerToSwitch event,
    Emitter<TeamsState> emit,
  ) {
    Player? switchingPlayer =
        state.switchingPlayer == event.player ? null : event.player;
    emit(state.copyWith(
        status: TeamsStatus.similarPlayersLoaded, similarPlayers: []));
    if (switchingPlayer != null) {
      List<SimilarPlayer> similarPlayers = teamsService
          .getSimilarPlayers(state.teams, event.player)
          .map(
            (similarPlayer) => SimilarPlayer(
              similarPlayer,
              event.player.similarity(similarPlayer),
              teamsService.avgDiffOnSwap(
                  state.teams, event.player, similarPlayer),
            ),
          )
          .toList();
      emit(
        state.copyWith(
            status: TeamsStatus.similarPlayersLoaded,
            similarPlayers: similarPlayers,
            switchingPlayer: event.player),
      );
    }
  }
}
