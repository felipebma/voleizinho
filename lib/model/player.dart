// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:objectbox/objectbox.dart';
import 'package:voleizinho/model/skills.dart';
import 'package:voleizinho/services/groups/group_service.dart';

@Entity()
class Player extends Equatable {
  @Id()
  int id = 0;

  Player();
  Player.withArgs({
    this.id = 0,
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

  double getSkillFromName(String skillName) {
    return skills[skillName]!.toDouble();
  }

  double getSkill(Skill skill) {
    return skills[skill]!.toDouble();
  }

  double getAverage() {
    return GetIt.I<GroupService>().getPlayerAverage(this);
  }

  double similarity(Player player) {
    return GetIt.I<GroupService>().calculateSimilarity(this, player);
  }

  copyWith({int? id, String? name, Map<Skill, int>? skills, int? groupId}) {
    return Player.withArgs(
      id: id ?? this.id,
      name: name ?? this.name,
      skills: skills ?? {...this.skills},
      groupId: groupId ?? this.groupId,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
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
        id: jsonObject['id'] ?? 0,
        name: jsonObject['name'],
        skills: skills,
        groupId: jsonObject['groupId']);
  }

  @override
  List<Object?> get props => [id, name, skills, groupId];
}
