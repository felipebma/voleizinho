import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/model/skills.dart';

Player kDefaultPlayer = Player(
  name: "Jogador",
  skills: {
    Skill.spike: 3,
    Skill.agility: 3,
    Skill.block: 3,
    Skill.receive: 3,
    Skill.serve: 3,
    Skill.set: 3,
  },
);

List<Player> playersDB = [
  Player(name: "Felipe", skills: {
    Skill.spike: 4,
    Skill.agility: 2,
    Skill.block: 3,
    Skill.receive: 3,
    Skill.serve: 5,
    Skill.set: 4,
  }),
  Player(name: "Clara", skills: {
    Skill.spike: 2,
    Skill.agility: 4,
    Skill.block: 3,
    Skill.receive: 3,
    Skill.serve: 3,
    Skill.set: 3,
  }),
];
