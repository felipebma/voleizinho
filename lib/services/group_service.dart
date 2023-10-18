import 'package:voleizinho/model/group.dart';
import 'package:voleizinho/model/skills.dart';
import 'package:voleizinho/repositories/group_repository.dart';
import 'package:voleizinho/services/user_preferences.dart';

class GroupService {
  static final GroupRepository groupRepository = GroupRepository();

  static List<Group> getGroups() {
    return groupRepository.getGroups();
  }

  static int createGroup(Group group) {
    return groupRepository.addGroup(group);
  }

  static void updateGroup(Group newGroup) {
    groupRepository.updateGroup(newGroup);
  }

  static void removeGroup(Group group) {
    groupRepository.removeGroup(group);
  }

  static Group activeGroup() {
    return groupRepository.getGroupById(UserPreferences.getGroup()!);
  }

  static Map<Skill, int> getSkillsWeights() {
    return activeGroup().skillsWeights;
  }

  static void updateSkillsWeights(Map<Skill, int> weights) {
    Group group = activeGroup();
    group.skillsWeights = weights;
    updateGroup(group);
  }
}
