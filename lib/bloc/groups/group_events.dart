import 'package:voleizinho/model/group.dart';

abstract class GroupEvent {}

class GroupsLoadEvent extends GroupEvent {}

class GroupCreateEvent extends GroupEvent {
  final Group group;

  GroupCreateEvent(this.group);
}

class GroupUpdateEvent extends GroupEvent {
  final Group group;

  GroupUpdateEvent(this.group);
}

class GroupDeleteEvent extends GroupEvent {
  final Group group;

  GroupDeleteEvent(this.group);
}

class GroupSelectEvent extends GroupEvent {
  final Group group;

  GroupSelectEvent(this.group);
}
