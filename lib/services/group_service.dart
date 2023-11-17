import 'package:get_it/get_it.dart';
import 'package:voleizinho/model/group.dart';
import 'package:voleizinho/model/skills.dart';
import 'package:voleizinho/repositories/group_repository.dart';
import 'package:voleizinho/services/player_service.dart';

class GroupService {
  final GroupRepository groupRepository = GetIt.instance.get<GroupRepository>();

  List<Group> getGroups() {
    return groupRepository.getGroups();
  }

  int createGroup(Group group) {
    return groupRepository.addGroup(group);
  }

  void updateGroup(Group newGroup) {
    groupRepository.updateGroup(newGroup);
  }

  void removeGroup(Group group) {
    PlayerService.staticRemovePlayersFromGroup(group.id);
    groupRepository.removeGroup(group);
  }

  Map<Skill, int> getSkillsWeights(int groupId) {
    return groupRepository.getGroupById(groupId).skillsWeights;
  }

  void updateSkillsWeights(int groupId, Map<Skill, int> weights) {
    Group group = groupRepository.getGroupById(groupId);
    group.skillsWeights = weights;
    updateGroup(group);
  }
}
