import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/model/skills.dart';

class Team {
  Team() {
    players = [];
  }

  List<Player> players = [];

  double getAverage(Map<Skill, int> skillsWeights) {
    double sum = 0;
    for (var player in players) {
      sum += player.getAverage(skillsWeights);
    }

    return sum / players.length;
  }

  void addPlayer(Player player) {
    players.add(player);
  }

  void removePlayer(Player player) {
    players.remove(player);
  }

  List<Player> getPlayers() {
    return players;
  }

  Map<String, dynamic> toJson() {
    return {
      'players': players.map((e) => e.toJson()).toList(),
    };
  }

  Team.fromJson(Map<String, dynamic> json) {
    players = json['players']
        .map<Player>((e) => Player.fromJson(e))
        .toList()
        .cast<Player>();
  }

  double getPlayerAtk(Player player, Map<Skill, int> skillsWeights) {
    double atk = player.getSkill(Skill.spike) * skillsWeights[Skill.spike]! +
        player.getSkill(Skill.set) * skillsWeights[Skill.set]! +
        player.getSkill(Skill.block) * skillsWeights[Skill.block]!;
    return atk /
        (skillsWeights[Skill.spike]! +
            skillsWeights[Skill.set]! +
            skillsWeights[Skill.block]!);
  }

  double getPlayerDef(Player player, Map<Skill, int> skillsWeights) {
    double atk = player.getSkill(Skill.serve) * skillsWeights[Skill.serve]! +
        player.getSkill(Skill.receive) * skillsWeights[Skill.receive]! +
        player.getSkill(Skill.agility) * skillsWeights[Skill.agility]!;
    return atk /
        (skillsWeights[Skill.serve]! +
            skillsWeights[Skill.receive]! +
            skillsWeights[Skill.agility]!);
  }

  double getDifference(Team team, Map<Skill, int> skillsWeights) {
    double atk = 0, def = 0;
    for (Player p in players) {
      def += getPlayerDef(p, skillsWeights) / players.length;
      atk += getPlayerAtk(p, skillsWeights) / players.length;
    }
    double atk2 = 0, def2 = 0;
    for (Player p in team.players) {
      atk2 += getPlayerAtk(p, skillsWeights) / team.players.length;
      def2 += getPlayerDef(p, skillsWeights) / team.players.length;
    }
    return (atk - atk2).abs() + (def - def2).abs();
  }
}
