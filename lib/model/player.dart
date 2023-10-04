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
      skills: skills ?? this.skills,
    );
  }
}
