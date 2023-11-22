import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/model/skills.dart';
import 'package:voleizinho/services/group_service.dart';

class Team {
  Team() {
    players = [];
  }

  List<Player> players = [];

  double getAverage() {
    double sum = 0;
    for (var player in players) {
      sum += player.getAverage();
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

  double getPlayerAtk(Player player) {
    Map<Skill, int> weights = GroupService.I.getSkillsWeights();
    double atk = player.getSkill(Skill.spike) * weights[Skill.spike]! +
        player.getSkill(Skill.set) * weights[Skill.set]! +
        player.getSkill(Skill.block) * weights[Skill.block]!;
    return atk /
        (weights[Skill.spike]! + weights[Skill.set]! + weights[Skill.block]!);
  }

  double getPlayerDef(Player player) {
    Map<Skill, int> weights = GroupService.I.getSkillsWeights();
    double atk = player.getSkill(Skill.serve) * weights[Skill.serve]! +
        player.getSkill(Skill.receive) * weights[Skill.receive]! +
        player.getSkill(Skill.agility) * weights[Skill.agility]!;
    return atk /
        (weights[Skill.serve]! +
            weights[Skill.receive]! +
            weights[Skill.agility]!);
  }

  double getDifference(Team team) {
    double atk = 0, def = 0;
    for (Player p in players) {
      atk += getPlayerAtk(p) / players.length;
      def += getPlayerDef(p) / players.length;
    }
    double atk2 = 0, def2 = 0;
    for (Player p in team.players) {
      atk2 += getPlayerAtk(p) / team.players.length;
      def2 += getPlayerDef(p) / team.players.length;
    }
    return (atk - atk2).abs() + (def - def2).abs();
  }
}
