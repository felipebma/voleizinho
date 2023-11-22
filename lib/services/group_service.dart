import 'package:voleizinho/model/group.dart';
import 'package:voleizinho/model/skills.dart';
import 'package:voleizinho/repositories/group_repository.dart';
import 'package:voleizinho/services/player_service.dart';
import 'package:voleizinho/services/user_preferences.dart';

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
    return groupRepository.addGroup(group);
  }

  void updateGroup(Group newGroup) {
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
}
