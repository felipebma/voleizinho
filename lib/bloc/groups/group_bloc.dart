import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voleizinho/bloc/groups/group_events.dart';
import 'package:voleizinho/bloc/groups/group_states.dart';
import 'package:voleizinho/services/group_service.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  // ignore: unused_field
  final GroupService _groupService;

  GroupBloc(this._groupService) : super(GroupsLoadingState()) {
    on<GroupsLoadEvent>(_onLoadGroups);
    on<GroupCreateEvent>(_onCreateGroup);
    on<GroupUpdateEvent>(_onUpdateGroup);
    on<GroupDeleteEvent>(_onDeleteGroup);
    on<GroupSelectEvent>(_onSelectGroup);
  }

  void _onLoadGroups(GroupsLoadEvent event, Emitter<GroupState> emit) {
    emit(GroupsLoadedState(GroupService.getGroups()));
  }

  void _onCreateGroup(GroupCreateEvent event, Emitter<GroupState> emit) {
    GroupService.createGroup(event.group);
    emit(GroupCreatedState(event.group));
  }

  void _onUpdateGroup(GroupUpdateEvent event, Emitter<GroupState> emit) {
    GroupService.updateGroup(event.group);
    emit(GroupUpdatedState(event.group));
  }

  void _onDeleteGroup(GroupDeleteEvent event, Emitter<GroupState> emit) {
    GroupService.removeGroup(event.group);
    emit(GroupDeletedState());
  }

  void _onSelectGroup(GroupSelectEvent event, Emitter<GroupState> emit) {
    GroupService.updateGroup(event.group);
    emit(GroupSelectedState(event.group));
  }
}
