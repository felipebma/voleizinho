import 'dart:convert';

import 'package:objectbox/objectbox.dart';
import 'package:voleizinho/model/skills.dart';

@Entity()
class Player {
  @Id()
  int id = 0;

  Player();
  Player.withArgs({this.name, required this.skills});
  String? name;

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
    skills.forEach((key, value) {
      sum += value;
    });
    return sum / skills.length;
  }

  copyWith({String? name, Map<Skill, int>? skills}) {
    return Player.withArgs(
      name: name ?? this.name,
      skills: skills ?? {...this.skills},
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'skills': json.encode({
          for (var entry in skills.entries) entry.key.name: entry.value,
        }),
      };

  factory Player.fromJson(Map<String, dynamic> jsonObject) {
    Map<String, dynamic> decoded = json.decode(jsonObject['skills']);
    Map<Skill, int> skills = {};
    for (var entry in decoded.entries) {
      Skill skill =
          Skill.values.firstWhere((e) => e.toString() == "Skill.${entry.key}");
      skills[skill] = entry.value;
    }

    return Player.withArgs(name: jsonObject['name'], skills: skills);
  }
}
