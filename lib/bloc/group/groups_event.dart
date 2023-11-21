import 'package:voleizinho/model/group.dart';

abstract class GroupsEvent {}

class LoadGroups extends GroupsEvent {}

class CreateGroupEvent extends GroupsEvent {
  final Group group;

  CreateGroupEvent(this.group);
}

class EditGroupEvent extends GroupsEvent {
  final Group group;

  EditGroupEvent(this.group);
}

class DeleteGroupEvent extends GroupsEvent {
  final Group group;

  DeleteGroupEvent(this.group);
}

class SetActiveGroupEvent extends GroupsEvent {
  final Group group;

  SetActiveGroupEvent(this.group);
}
