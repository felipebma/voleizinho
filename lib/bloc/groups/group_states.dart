import 'package:voleizinho/model/group.dart';

class GroupState {
  final Group? activeGroup;

  GroupState({this.activeGroup});
}

class GroupsLoadingState extends GroupState {
  GroupsLoadingState() : super(activeGroup: null);
}

class GroupsLoadedState extends GroupState {
  final List<Group> groups;

  GroupsLoadedState(this.groups) : super(activeGroup: groups.first);
}

class GroupCreatedState extends GroupState {
  final Group group;

  GroupCreatedState(this.group) : super(activeGroup: group);
}

class GroupUpdatedState extends GroupState {
  final Group group;

  GroupUpdatedState(this.group) : super(activeGroup: group);
}

class GroupDeletedState extends GroupState {
  GroupDeletedState() : super(activeGroup: null);
}

class GroupSelectedState extends GroupState {
  final Group group;

  GroupSelectedState(this.group) : super(activeGroup: group);
}
