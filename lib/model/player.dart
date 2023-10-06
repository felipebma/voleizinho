import 'dart:convert';

import 'package:objectbox/objectbox.dart';
import 'package:voleizinho/model/skills.dart';
import 'package:voleizinho/services/user_preferences.dart';

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
    var weights = UserPreferences.skillWeights;
    int sumWeights = 0;
    skills.forEach((key, value) {
      sum += value * (weights[key] ?? 1);
      sumWeights += weights[key] ?? 1;
    });
    return sum / sumWeights;
  }

  double similarity(Player player) {
    double sum = 0;
    var weights = UserPreferences.skillWeights;
    int sumWeights = 0;
    skills.forEach((key, value) {
      sum += ((value - player.skills[key]!).abs()) * (weights[key] ?? 1);
      sumWeights += 50;
    });
    return 1 - sum / sumWeights;
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
