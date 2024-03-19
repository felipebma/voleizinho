import 'package:voleizinho/exceptions/group/group_name_already_existis_exception.dart';
import 'package:voleizinho/exceptions/group/group_name_is_empty_exception.dart';
import 'package:voleizinho/model/group.dart';
import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/model/skills.dart';
import 'package:voleizinho/repositories/group_repository.dart';
import 'package:voleizinho/services/user_preferences/user_preferences.dart';

class GroupService {
  final GroupRepository groupRepository;

  GroupService(this.groupRepository);

  List<Group> getGroups() {
    return groupRepository.getGroups();
  }

  Group getGroupById(int id) {
    return groupRepository.getGroupById(id)!;
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
    groupRepository.removeGroup(group);
  }

  Group activeGroup() {
    return groupRepository.getGroupById(UserPreferences.getGroup()!)!;
  }

  Map<Skill, num> getSkillsWeights() {
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

  double getPlayerAverage(Player player) {
    double sum = 0;
    num sumWeights = 0;
    Map<Skill, num> weights = getSkillsWeights();
    player.skills.forEach((key, value) {
      sum += value * (weights[key] ?? 1);
      sumWeights += weights[key] ?? 1;
    });
    return sum / sumWeights;
  }

  double getPlayerAtk(Player player) {
    Map<Skill, num> weights = getSkillsWeights();
    double atk = player.getSkill(Skill.spike) * weights[Skill.spike]! +
        player.getSkill(Skill.set) * weights[Skill.set]! +
        player.getSkill(Skill.block) * weights[Skill.block]!;
    return atk /
        (weights[Skill.spike]! + weights[Skill.set]! + weights[Skill.block]!);
  }

  double getPlayerDef(Player player) {
    Map<Skill, num> weights = getSkillsWeights();
    double atk = player.getSkill(Skill.serve) * weights[Skill.serve]! +
        player.getSkill(Skill.receive) * weights[Skill.receive]! +
        player.getSkill(Skill.agility) * weights[Skill.agility]!;
    return atk /
        (weights[Skill.serve]! +
            weights[Skill.receive]! +
            weights[Skill.agility]!);
  }

  double calculateSimilarity(Player p1, Player p2) {
    double sum = 0;
    num sumWeights = 0;
    Map<Skill, num> weights = getSkillsWeights();
    p1.skills.forEach((key, value) {
      sum += ((value - p2.skills[key]!).abs()) * (weights[key] ?? 1);
      sumWeights += (weights[key] ?? 1) * 5;
    });
    return 1 - sum / sumWeights;
  }
}
