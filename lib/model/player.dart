import 'dart:convert';

import 'package:objectbox/objectbox.dart';
import 'package:voleizinho/model/skills.dart';
import 'package:voleizinho/services/group_service.dart';

@Entity()
class Player {
  @Id()
  int id = 0;

  Player();
  Player.withArgs({
    this.name,
    required this.skills,
    this.groupId = 0,
  });
  String? name;

  int groupId = 0;

  @Transient()
  Map<Skill, int> skills = {};

  String? get dbSkills {
    return json.encode({
      for (var entry in skills.entries) entry.key.name: entry.value,
    });
  }

  set dbSkills(String? skills) {
    if (skills != null) {
      Map<String, dynamic> decoded = json.decode(skills);
      for (var entry in decoded.entries) {
        Skill skill = Skill.values
            .firstWhere((e) => e.toString() == "Skill.${entry.key}");
        this.skills[skill] = entry.value;
      }
    }
  }

  double getSkill(String skillName) {
    return skills[skillName]!.toDouble();
  }

  double getAverage() {
    double sum = 0;
    var weights = GroupService.getSkillsWeights();
    int sumWeights = 0;
    skills.forEach((key, value) {
      sum += value * (weights[key] ?? 1);
      sumWeights += weights[key] ?? 1;
    });
    return sum / sumWeights;
  }

  double similarity(Player player) {
    double sum = 0;
    var weights = GroupService.getSkillsWeights();
    int sumWeights = 0;
    skills.forEach((key, value) {
      sum += ((value - player.skills[key]!).abs()) * (weights[key] ?? 1);
      sumWeights += (weights[key] ?? 1) * 5;
    });
    return 1 - sum / sumWeights;
  }

  copyWith({String? name, Map<Skill, int>? skills, int? groupId}) {
    return Player.withArgs(
      name: name ?? this.name,
      skills: skills ?? {...this.skills},
      groupId: groupId ?? this.groupId,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'skills': json.encode(
          {
            for (var entry in skills.entries) entry.key.name: entry.value,
          },
        ),
        'groupId': groupId
      };

  factory Player.fromJson(Map<String, dynamic> jsonObject) {
    Map<String, dynamic> decoded = json.decode(jsonObject['skills']);
    Map<Skill, int> skills = {};
    for (var entry in decoded.entries) {
      Skill skill =
          Skill.values.firstWhere((e) => e.toString() == "Skill.${entry.key}");
      skills[skill] = entry.value;
    }

    return Player.withArgs(
        name: jsonObject['name'],
        skills: skills,
        groupId: jsonObject['groupId']);
  }
}
