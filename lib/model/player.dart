import 'dart:convert';

import 'package:voleizinho/model/skills.dart';

class Player {
  Player({required this.name, required this.skills});
  String name;
  Map<Skill, int> skills = {};

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
    return Player(
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

    return Player(name: jsonObject['name'], skills: skills);
  }
}
