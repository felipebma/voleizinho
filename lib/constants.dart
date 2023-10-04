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
    Skill.agility: 1,
    Skill.block: 3,
    Skill.receive: 3,
    Skill.serve: 4,
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
  Player(name: "Maria", skills: {
    Skill.spike: 2,
    Skill.agility: 5,
    Skill.block: 0,
    Skill.receive: 5,
    Skill.serve: 3,
    Skill.set: 3,
  }),
  Player(name: "Amancio", skills: {
    Skill.spike: 4,
    Skill.agility: 4,
    Skill.block: 4,
    Skill.receive: 3,
    Skill.serve: 3,
    Skill.set: 3,
  }),
  Player(name: "Vini", skills: {
    Skill.spike: 4,
    Skill.agility: 4,
    Skill.block: 4,
    Skill.receive: 3,
    Skill.serve: 2,
    Skill.set: 3,
  }),
  Player(name: "Daniel", skills: {
    Skill.spike: 2,
    Skill.agility: 3,
    Skill.block: 2,
    Skill.receive: 2,
    Skill.serve: 3,
    Skill.set: 2,
  }),
  Player(name: "Juca", skills: {
    Skill.spike: 4,
    Skill.agility: 4,
    Skill.block: 4,
    Skill.receive: 4,
    Skill.serve: 5,
    Skill.set: 4,
  }),
];
