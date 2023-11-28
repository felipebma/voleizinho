import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voleizinho/bloc/team/teams_event.dart';
import 'package:voleizinho/bloc/team/teams_state.dart';
import 'package:voleizinho/model/group.dart';
import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/model/similar_player.dart';
import 'package:voleizinho/model/team.dart';
import 'package:voleizinho/services/groups/group_service.dart';
import 'package:voleizinho/services/teams/team_service.dart';

class TeamsBloc extends Bloc<TeamsEvent, TeamsState> {
  final TeamService teamsService = TeamService.getInstance();
  final GroupService groupService = GroupService.getInstance();

  TeamsBloc() : super(const TeamsState()) {
    on<LoadTeams>(_getTeams);
    on<CreateTeams>(_createTeams);
    on<SelectPlayer>(_selectPlayer);
    on<SwapPlayers>(_swapPlayers);
    on<GetSimilarPlayers>(_getSimilarPlayers);
  }

  Future<void> _getTeams(
    LoadTeams event,
    Emitter<TeamsState> emit,
  ) async {
    emit(state.copyWith(status: TeamsStatus.loading));
    try {
      final teams = await teamsService.getTeams(event.groupId);
      emit(state.copyWith(status: TeamsStatus.loaded, teams: teams));
      print(teams);
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
      await teamsService.createTeams(event.groupId, event.players,
          event.playersPerTeam, usePositionalBalancing);
      final teams = await teamsService.getTeams(event.groupId);
      emit(state.copyWith(status: TeamsStatus.created, teams: teams));
      print(teams);
    } catch (e) {
      emit(state.copyWith(
          status: TeamsStatus.error, errorMessage: e.toString()));
    }
  }

  void _selectPlayer(
    SelectPlayer event,
    Emitter<TeamsState> emit,
  ) {
    List<Player> selectedPlayers = state.selectedPlayers;
    if (selectedPlayers.contains(event.player)) {
      selectedPlayers.remove(event.player);
    } else {
      selectedPlayers.add(event.player);
    }
    emit(state.copyWith(selectedPlayers: selectedPlayers));
  }

  void _swapPlayers(
    SwapPlayers event,
    Emitter<TeamsState> emit,
  ) async {
    List<Team> teams = state.teams;
    teamsService.swapPlayers(
        event.groupId, teams, event.player1, event.player2);
    emit(state.copyWith(teams: teams));
  }

  void _getSimilarPlayers(
    GetSimilarPlayers event,
    Emitter<TeamsState> emit,
  ) {
    emit(state.copyWith(similarPlayers: []));
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
    print(similarPlayers.length);
    emit(state.copyWith(similarPlayers: similarPlayers));
  }
}
