import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voleizinho/bloc/groups/group_events.dart';
import 'package:voleizinho/bloc/groups/group_states.dart';
import 'package:voleizinho/services/group_service.dart';
import 'package:voleizinho/services/user_preferences.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final GroupService _groupService;

  GroupBloc(this._groupService) : super(GroupsLoadingState()) {
    on<GroupsLoadEvent>(_onLoadGroups);
    on<GroupCreateEvent>(_onCreateGroup);
    on<GroupUpdateEvent>(_onUpdateGroup);
    on<GroupDeleteEvent>(_onDeleteGroup);
    on<GroupSelectEvent>(_onSelectGroup);
  }

  void _onLoadGroups(GroupsLoadEvent event, Emitter<GroupState> emit) {
    emit(GroupsLoadedState(_groupService.getGroups()));
  }

  void _onCreateGroup(GroupCreateEvent event, Emitter<GroupState> emit) {
    _groupService.createGroup(event.group);
    emit(GroupCreatedState(event.group));
  }

  void _onUpdateGroup(GroupUpdateEvent event, Emitter<GroupState> emit) {
    _groupService.updateGroup(event.group);
    emit(GroupUpdatedState(event.group));
  }

  void _onDeleteGroup(GroupDeleteEvent event, Emitter<GroupState> emit) {
    _groupService.removeGroup(event.group);
    emit(GroupDeletedState());
  }

  void _onSelectGroup(GroupSelectEvent event, Emitter<GroupState> emit) {
    UserPreferences.setGroup(event.group.id);
    _groupService.updateGroup(event.group);
    emit(GroupSelectedState(event.group));
  }
}
