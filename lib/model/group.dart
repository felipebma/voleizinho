import 'dart:convert';

import 'package:objectbox/objectbox.dart';
import 'package:voleizinho/model/skills.dart';

@Entity()
class Group {
  @Id()
  int id = 0;
  String? name;
  bool usePositionalBalacing = true;

  Group();

  Group.withArgs(
      {this.name,
      this.usePositionalBalacing = true,
      this.skillsWeights = const {
        Skill.spike: 1,
        Skill.agility: 1,
        Skill.block: 1,
        Skill.receive: 1,
        Skill.serve: 1,
        Skill.set: 1,
      }});

  @Transient()
  Map<Skill, int> skillsWeights = {};

  String? get dbSkillsWeights {
    return json.encode({
      for (var entry in skillsWeights.entries) entry.key.name: entry.value,
    });
  }

  set dbSkillsWeights(String? skillsWeights) {
    if (skillsWeights != null) {
      Map<String, dynamic> decoded = json.decode(skillsWeights);
      for (var entry in decoded.entries) {
        Skill skill = Skill.values
            .firstWhere((e) => e.toString() == "Skill.${entry.key}");
        this.skillsWeights[skill] = entry.value;
      }
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'usePositionalBalacing': usePositionalBalacing,
      'skillsWeights': skillsWeights,
    };
  }

  factory Group.fromJson(Map<String, dynamic> jsonObject) {
    Map<String, dynamic> decoded = json.decode(jsonObject['skillsWeights']);
    Map<Skill, int> skillsWeights = {};
    for (var entry in decoded.entries) {
      Skill skill =
          Skill.values.firstWhere((e) => e.toString() == "Skill.${entry.key}");
      skillsWeights[skill] = entry.value;
    }

    return Group.withArgs(
        name: jsonObject['name'],
        usePositionalBalacing: jsonObject['usePositionalBalancing'],
        skillsWeights: skillsWeights);
  }
}
