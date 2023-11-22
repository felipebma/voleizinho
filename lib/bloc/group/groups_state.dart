import 'package:voleizinho/model/group.dart';

enum GroupsStatus {
  initial,
  loading,
  loaded,
  selected,
  created,
  edited,
  deleted,
  error
}

class GroupsState {
  final GroupsStatus status;
  final Group? activeGroup;
  final List<Group> groups;
  final String? errorMessage;

  GroupsState({
    required this.status,
    this.activeGroup,
    required this.groups,
    this.errorMessage,
  });

  factory GroupsState.initial() =>
      GroupsState(status: GroupsStatus.initial, groups: []);

  GroupsState copyWith({
    GroupsStatus? status,
    Group? activeGroup,
    List<Group>? groups,
    String? errorMessage,
  }) {
    return GroupsState(
      status: status ?? this.status,
      activeGroup: activeGroup ?? this.activeGroup,
      groups: groups ?? this.groups,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
