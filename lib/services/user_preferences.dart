import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:voleizinho/model/skills.dart';
import 'package:voleizinho/model/team.dart';

class UserPreferences {
  static final Map<Skill, int> _skillWeights = <Skill, int>{};

  static Future<Map<Skill, int>> initUserPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (Skill skill in Skill.values) {
      _skillWeights[skill] = prefs.getInt(skill.toString()) ?? 1;
    }
    return _skillWeights;
  }

  static void updateSkillWeight(Map<Skill, int> weights) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (Skill skill in weights.keys) {
      prefs.setInt(skill.toString(), weights[skill] ?? 1);
      _skillWeights[skill] = weights[skill] ?? 1;
    }
  }

  static Future<void> setTeams(List<Team> teams) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        "teams", teams.map((e) => json.encode(e.toJson())).toList());
  }

  static Future<List<Team>> getTeams() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> teams = prefs.getStringList("teams") ?? [];
    return teams.map((e) => Team.fromJson(json.decode(e))).toList();
  }

  static Future<void> saveScores(int score1, int score2) async {
    await SharedPreferences.getInstance().then((prefs) {
      prefs.setInt("score1", score1);
      prefs.setInt("score2", score2);
    });
    return;
  }

  static Future<List<int>> getScores() {
    return SharedPreferences.getInstance().then((prefs) {
      int score1 = prefs.getInt("score1") ?? 0;
      int score2 = prefs.getInt("score2") ?? 0;
      print("get scores");
      return [score1, score2];
    });
  }

  static Map<Skill, int> get skillWeights {
    return {..._skillWeights};
  }
}
