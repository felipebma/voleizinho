import 'package:shared_preferences/shared_preferences.dart';
import 'package:voleizinho/model/skills.dart';

class UserPreferences {
  static Map<Skill, int> _skillWeights = Map<Skill, int>();

  static Future<Map<Skill, int>> init_user_preferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (Skill skill in Skill.values) {
      _skillWeights[skill] = prefs.getInt(skill.toString()) ?? 1;
    }
    return _skillWeights;
  }

  static void update_skill_weight(Map<Skill, int> weights) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (Skill skill in weights.keys) {
      prefs.setInt(skill.toString(), weights[skill] ?? 1);
      _skillWeights[skill] = weights[skill] ?? 1;
    }
  }

  static Map<Skill, int> get skillWeights {
    return {..._skillWeights};
  }
}
