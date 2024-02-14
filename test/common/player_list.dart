import 'package:voleizinho/constants.dart';
import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/model/skills.dart';

List<Player> players = [
  Player.withArgs(
    id: 1,
    name: "Player 1",
    groupId: 1,
    skills: const {
      Skill.spike: 0,
      Skill.block: 0,
      Skill.serve: 0,
      Skill.agility: 0,
      Skill.receive: 0,
      Skill.set: 0,
    },
  ),
  kDefaultPlayer.copyWith(
    id: 2,
    name: "Player 2",
    groupId: 1,
  ),
  kDefaultPlayer.copyWith(
    id: 3,
    name: "Player 3",
    groupId: 1,
  ),
  Player.withArgs(
    id: 4,
    name: "Player 4",
    groupId: 1,
    skills: const {
      Skill.spike: 5,
      Skill.block: 5,
      Skill.serve: 5,
      Skill.agility: 5,
      Skill.receive: 5,
      Skill.set: 5,
    },
  ),
];
