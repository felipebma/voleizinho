import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/model/skills.dart';

Player kDefaultPlayer = Player.withArgs(
  name: "Jogador",
  skills: const {
    Skill.spike: 3,
    Skill.agility: 3,
    Skill.block: 3,
    Skill.receive: 3,
    Skill.serve: 3,
    Skill.set: 3,
  },
);
