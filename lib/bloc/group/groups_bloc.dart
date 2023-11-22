import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voleizinho/bloc/group/groups_event.dart';
import 'package:voleizinho/bloc/group/groups_state.dart';
import 'package:voleizinho/services/group_service.dart';

class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  final GroupService groupService = GroupService.getInstance();

  GroupsBloc() : super(GroupsState.initial()) {
    on<LoadGroups>(_loadGroups);
    on<CreateGroupEvent>(_createGroup);
    on<EditGroupEvent>(_editGroup);
    on<DeleteGroupEvent>(_deleteGroup);
    on<SetActiveGroupEvent>(_setActiveGroup);
  }

  void _loadGroups(LoadGroups event, Emitter<GroupsState> emit) async {
    emit(state.copyWith(status: GroupsStatus.loading));
    try {
      emit(state.copyWith(
          status: GroupsStatus.loaded, groups: groupService.getGroups()));
    } catch (e) {
      emit(state.copyWith(
          status: GroupsStatus.error, errorMessage: e.toString()));
    }
  }

  void _createGroup(CreateGroupEvent event, Emitter<GroupsState> emit) async {
    emit(state.copyWith(status: GroupsStatus.loading));
    try {
      int id = groupService.createGroup(event.group);
      emit(state.copyWith(
          status: GroupsStatus.created,
          groups: groupService.getGroups(),
          activeGroup: groupService.getGroupById(id)));
    } catch (e) {
      emit(state.copyWith(
          status: GroupsStatus.error, errorMessage: e.toString()));
    }
  }

  void _editGroup(EditGroupEvent event, Emitter<GroupsState> emit) async {
    try {
      groupService.updateGroup(event.group);

      emit(
        state.copyWith(
          status: GroupsStatus.edited,
          groups: groupService.getGroups(),
          activeGroup: event.group,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
          status: GroupsStatus.error, errorMessage: e.toString()));
    }
  }

  void _deleteGroup(DeleteGroupEvent event, Emitter<GroupsState> emit) async {
    try {
      groupService.removeGroup(event.group);
      emit(state.copyWith(
          status: GroupsStatus.deleted, groups: groupService.getGroups()));
    } catch (e) {
      emit(state.copyWith(
          status: GroupsStatus.error, errorMessage: e.toString()));
    }
  }

  void _setActiveGroup(
      SetActiveGroupEvent event, Emitter<GroupsState> emit) async {
    try {
      emit(state.copyWith(
          status: GroupsStatus.loaded,
          groups: groupService.getGroups(),
          activeGroup: event.group));
    } catch (e) {
      emit(state.copyWith(
          status: GroupsStatus.error, errorMessage: e.toString()));
    }
  }
}
