import 'package:voleizinho/exceptions/group/group_name_already_existis_exception.dart';
import 'package:voleizinho/exceptions/group/group_name_is_empty_exception.dart';
import 'package:voleizinho/model/group.dart';
import 'package:voleizinho/model/skills.dart';
import 'package:voleizinho/repositories/group_repository.dart';
import 'package:voleizinho/services/players/player_service.dart';
import 'package:voleizinho/services/user_preferences/user_preferences.dart';

class GroupService {
  final GroupRepository groupRepository = GroupRepository();
  final PlayerService playerService = PlayerService.getInstance();

  static GroupService? _instance;

  static GroupService getInstance() {
    _instance ??= GroupService();
    return _instance!;
  }

  static get I => getInstance();

  List<Group> getGroups() {
    return groupRepository.getGroups();
  }

  Group getGroupById(int id) {
    return groupRepository.getGroupById(id);
  }

  int createGroup(Group group) {
    _validateGroup(group);
    return groupRepository.addGroup(group);
  }

  void updateGroup(Group newGroup) {
    _validateGroup(newGroup);
    groupRepository.updateGroup(newGroup);
  }

  void removeGroup(Group group) {
    playerService.removePlayersFromGroup(group.id);
    groupRepository.removeGroup(group);
  }

  Group activeGroup() {
    return groupRepository.getGroupById(UserPreferences.getGroup()!);
  }

  Map<Skill, int> getSkillsWeights() {
    return activeGroup().skillsWeights;
  }

  void updateSkillsWeights(Map<Skill, int> weights) {
    Group group = activeGroup();
    group.skillsWeights = weights;
    updateGroup(group);
  }

  void _validateGroup(Group group) {
    if (group.name == null || group.name!.isEmpty) {
      throw GroupNameIsEmptyException("Group name cannot be empty");
    }
    List<Group> groups = getGroups();
    for (var g in groups) {
      if (g.name == group.name && g.id != group.id) {
        throw GroupNameAlreadyExistsException("Group name already exists");
      }
    }
  }
}
