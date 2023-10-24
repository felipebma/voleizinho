import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/model/skills.dart';

List<Player> playersDB = [
  Player.withArgs(name: "Amancio", skills: {
    Skill.spike: 4,
    Skill.block: 4,
    Skill.set: 3,
    Skill.agility: 4,
    Skill.receive: 4,
    Skill.serve: 5,
  }),
  Player.withArgs(name: "Amandinha", skills: {
    Skill.spike: 1,
    Skill.block: 1,
    Skill.set: 1,
    Skill.agility: 1,
    Skill.receive: 2,
    Skill.serve: 2,
  }),
  Player.withArgs(name: "Ana Cardoso", skills: {
    Skill.spike: 3,
    Skill.block: 1,
    Skill.set: 3,
    Skill.agility: 4,
    Skill.receive: 4,
    Skill.serve: 3,
  }),
  Player.withArgs(name: "Arthur", skills: {
    Skill.spike: 4,
    Skill.block: 3,
    Skill.set: 4,
    Skill.agility: 4,
    Skill.receive: 4,
    Skill.serve: 4,
  }),
  Player.withArgs(name: "Clara", skills: {
    Skill.spike: 4,
    Skill.block: 3,
    Skill.set: 4,
    Skill.agility: 3,
    Skill.receive: 4,
    Skill.serve: 3,
  }),
  Player.withArgs(name: "Erick", skills: {
    Skill.spike: 3,
    Skill.block: 3,
    Skill.set: 3,
    Skill.agility: 3,
    Skill.receive: 3,
    Skill.serve: 3,
  }),
  Player.withArgs(name: "Euclides", skills: {
    Skill.spike: 5,
    Skill.block: 3,
    Skill.set: 5,
    Skill.agility: 4,
    Skill.receive: 4,
    Skill.serve: 5,
  }),
  Player.withArgs(name: "Felipe", skills: {
    Skill.spike: 4,
    Skill.block: 2,
    Skill.set: 5,
    Skill.agility: 2,
    Skill.receive: 4,
    Skill.serve: 5,
  }),
  Player.withArgs(name: "Gustavo (Matheus)", skills: {
    Skill.spike: 3,
    Skill.block: 3,
    Skill.set: 3,
    Skill.agility: 3,
    Skill.receive: 3,
    Skill.serve: 3,
  }),
  Player.withArgs(name: "Juca", skills: {
    Skill.spike: 4,
    Skill.block: 3,
    Skill.set: 5,
    Skill.agility: 3,
    Skill.receive: 4,
    Skill.serve: 4,
  }),
  Player.withArgs(name: "Julia", skills: {
    Skill.spike: 1,
    Skill.block: 1,
    Skill.set: 2,
    Skill.agility: 1,
    Skill.receive: 2,
    Skill.serve: 3,
  }),
  Player.withArgs(name: "Lucas (Matheus)", skills: {
    Skill.spike: 3,
    Skill.block: 3,
    Skill.set: 3,
    Skill.agility: 3,
    Skill.receive: 3,
    Skill.serve: 3,
  }),
  Player.withArgs(name: "Matheus", skills: {
    Skill.spike: 4,
    Skill.block: 3,
    Skill.set: 3,
    Skill.agility: 4,
    Skill.receive: 4,
    Skill.serve: 4,
  }),
  Player.withArgs(name: "Moises", skills: {
    Skill.spike: 3,
    Skill.block: 3,
    Skill.set: 3,
    Skill.agility: 3,
    Skill.receive: 3,
    Skill.serve: 3,
  }),
  Player.withArgs(name: "PV", skills: {
    Skill.spike: 3,
    Skill.block: 2,
    Skill.set: 2,
    Skill.agility: 2,
    Skill.receive: 3,
    Skill.serve: 3,
  }),
  Player.withArgs(name: "Saulo", skills: {
    Skill.spike: 3,
    Skill.block: 2,
    Skill.set: 2,
    Skill.agility: 3,
    Skill.receive: 3,
    Skill.serve: 2,
  }),
  Player.withArgs(name: "Vini (RedBull)", skills: {
    Skill.spike: 4,
    Skill.block: 4,
    Skill.set: 2,
    Skill.agility: 4,
    Skill.receive: 2,
    Skill.serve: 2,
  }),
  Player.withArgs(name: "Adelmo", skills: {
    Skill.spike: 3,
    Skill.agility: 5,
    Skill.block: 1,
    Skill.receive: 5,
    Skill.serve: 3,
    Skill.set: 3,
  }),
  Player.withArgs(name: "Bianca", skills: {
    Skill.spike: 2,
    Skill.agility: 2,
    Skill.block: 1,
    Skill.receive: 3,
    Skill.serve: 3,
    Skill.set: 3,
  }),
  Player.withArgs(name: "Bruna", skills: {
    Skill.spike: 5,
    Skill.agility: 5,
    Skill.block: 3,
    Skill.receive: 5,
    Skill.set: 5,
    Skill.serve: 5,
  }),
  Player.withArgs(name: "Clara (Wesley)", skills: {
    Skill.set: 2,
    Skill.spike: 1,
    Skill.block: 0,
    Skill.serve: 3,
    Skill.receive: 3,
    Skill.agility: 2,
  }),
  Player.withArgs(name: "Edu", skills: {
    Skill.set: 4,
    Skill.spike: 4,
    Skill.block: 4,
    Skill.serve: 3,
    Skill.receive: 3,
    Skill.agility: 4,
  }),
  Player.withArgs(name: "Jardel", skills: {
    Skill.set: 1,
    Skill.spike: 2,
    Skill.block: 1,
    Skill.serve: 2,
    Skill.receive: 1,
    Skill.agility: 3,
  }),
  Player.withArgs(name: "Jurandir", skills: {
    Skill.set: 3,
    Skill.spike: 3,
    Skill.block: 2,
    Skill.serve: 3,
    Skill.receive: 3,
    Skill.agility: 4,
  }),
  Player.withArgs(name: "Lucas Morais", skills: {
    Skill.set: 1,
    Skill.spike: 2,
    Skill.block: 3,
    Skill.serve: 3,
    Skill.receive: 2,
    Skill.agility: 2,
  }),
  Player.withArgs(name: "Marcio", skills: {
    Skill.set: 2,
    Skill.spike: 1,
    Skill.block: 1,
    Skill.serve: 2,
    Skill.receive: 1,
    Skill.agility: 2,
  }),
  Player.withArgs(name: "PG", skills: {
    Skill.set: 3,
    Skill.spike: 5,
    Skill.block: 4,
    Skill.serve: 3,
    Skill.receive: 5,
    Skill.agility: 5,
  }),
  Player.withArgs(name: "Stefano", skills: {
    Skill.set: 0,
    Skill.spike: 1,
    Skill.block: 0,
    Skill.serve: 2,
    Skill.receive: 1,
    Skill.agility: 0,
  }),
  Player.withArgs(name: "Wesley", skills: {
    Skill.set: 3,
    Skill.spike: 3,
    Skill.block: 3,
    Skill.serve: 3,
    Skill.receive: 3,
    Skill.agility: 3,
  }),
  Player.withArgs(name: "Maria", skills: {
    Skill.spike: 2,
    Skill.agility: 5,
    Skill.block: 0,
    Skill.receive: 5,
    Skill.serve: 3,
    Skill.set: 3,
  }),
  Player.withArgs(name: "Daniel", skills: {
    Skill.spike: 2,
    Skill.agility: 3,
    Skill.block: 2,
    Skill.receive: 2,
    Skill.serve: 3,
    Skill.set: 2,
  }),
];

List<Player> playersQuartas = [
  Player.withArgs(
    name: "Aldenis",
    skills: {
      Skill.spike: 3,
      Skill.block: 3,
      Skill.set: 3,
      Skill.agility: 3,
      Skill.receive: 3,
      Skill.serve: 3,
    },
  ),
  Player.withArgs(
    name: "Amancio",
    skills: {
      Skill.spike: 5,
      Skill.block: 4,
      Skill.set: 4,
      Skill.agility: 4,
      Skill.receive: 4,
      Skill.serve: 5,
    },
  ),
  Player.withArgs(
    name: "Amanda(Duda)",
    skills: {
      Skill.spike: 1,
      Skill.block: 0,
      Skill.set: 1,
      Skill.agility: 1,
      Skill.receive: 1,
      Skill.serve: 3,
    },
  ),
  Player.withArgs(
    name: "Amandinha",
    skills: {
      Skill.spike: 1,
      Skill.block: 0,
      Skill.set: 1,
      Skill.agility: 1,
      Skill.receive: 1,
      Skill.serve: 3,
    },
  ),
  Player.withArgs(
    name: "Ana Cardoso",
    skills: {
      Skill.spike: 2,
      Skill.block: 0,
      Skill.set: 3,
      Skill.agility: 4,
      Skill.receive: 5,
      Skill.serve: 3,
    },
  ),
  Player.withArgs(
    name: "Ana Clara",
    skills: {
      Skill.spike: 1,
      Skill.block: 1,
      Skill.set: 3,
      Skill.agility: 2,
      Skill.receive: 3,
      Skill.serve: 3,
    },
  ),
  Player.withArgs(
    name: "Anna Jéssica",
    skills: {
      Skill.spike: 0,
      Skill.block: 0,
      Skill.set: 0,
      Skill.agility: 1,
      Skill.receive: 1,
      Skill.serve: 1,
    },
  ),
  Player.withArgs(
    name: "Arthur",
    skills: {
      Skill.spike: 4,
      Skill.block: 3,
      Skill.set: 4,
      Skill.agility: 4,
      Skill.receive: 4,
      Skill.serve: 4,
    },
  ),
  Player.withArgs(
    name: "Caio",
    skills: {
      Skill.spike: 5,
      Skill.block: 5,
      Skill.set: 5,
      Skill.agility: 5,
      Skill.receive: 5,
      Skill.serve: 5,
    },
  ),
  Player.withArgs(
    name: "Clara",
    skills: {
      Skill.spike: 3,
      Skill.block: 3,
      Skill.set: 3,
      Skill.agility: 3,
      Skill.receive: 3,
      Skill.serve: 3,
    },
  ),
  Player.withArgs(
    name: "Cristiane",
    skills: {
      Skill.spike: 2,
      Skill.block: 1,
      Skill.set: 2,
      Skill.agility: 2,
      Skill.receive: 2,
      Skill.serve: 2,
    },
  ),
  Player.withArgs(
    name: "Davi",
    skills: {
      Skill.spike: 3,
      Skill.block: 4,
      Skill.set: 3,
      Skill.agility: 3,
      Skill.receive: 3,
      Skill.serve: 4,
    },
  ),
  Player.withArgs(
    name: "Duda",
    skills: {
      Skill.spike: 2,
      Skill.block: 1,
      Skill.set: 2,
      Skill.agility: 3,
      Skill.receive: 2,
      Skill.serve: 3,
    },
  ),
  Player.withArgs(
    name: "Erick",
    skills: {
      Skill.spike: 2,
      Skill.block: 3,
      Skill.set: 3,
      Skill.agility: 3,
      Skill.receive: 3,
      Skill.serve: 3,
    },
  ),
  Player.withArgs(
    name: "Euclides",
    skills: {
      Skill.spike: 4,
      Skill.block: 3,
      Skill.set: 3,
      Skill.agility: 4,
      Skill.receive: 4,
      Skill.serve: 5,
    },
  ),
  Player.withArgs(
    name: "Felipe",
    skills: {
      Skill.spike: 4,
      Skill.block: 2,
      Skill.set: 4,
      Skill.agility: 2,
      Skill.receive: 4,
      Skill.serve: 5,
    },
  ),
  Player.withArgs(
    name: "Gabi Leal",
    skills: {
      Skill.spike: 3,
      Skill.block: 0,
      Skill.set: 4,
      Skill.agility: 3,
      Skill.receive: 4,
      Skill.serve: 3,
    },
  ),
  Player.withArgs(
    name: "Gustavo",
    skills: {
      Skill.spike: 5,
      Skill.block: 4,
      Skill.set: 5,
      Skill.agility: 4,
      Skill.receive: 5,
      Skill.serve: 5,
    },
  ),
  Player.withArgs(
    name: "Gustavo (Matheus)",
    skills: {
      Skill.spike: 4,
      Skill.block: 3,
      Skill.set: 4,
      Skill.agility: 4,
      Skill.receive: 4,
      Skill.serve: 4,
    },
  ),
  Player.withArgs(
    name: "Juca",
    skills: {
      Skill.spike: 4,
      Skill.block: 3,
      Skill.set: 5,
      Skill.agility: 3,
      Skill.receive: 4,
      Skill.serve: 4,
    },
  ),
  Player.withArgs(
    name: "Julia",
    skills: {
      Skill.spike: 1,
      Skill.block: 1,
      Skill.set: 2,
      Skill.agility: 1,
      Skill.receive: 2,
      Skill.serve: 2,
    },
  ),
  Player.withArgs(
    name: "Julia (Douglas)",
    skills: {
      Skill.spike: 2,
      Skill.block: 1,
      Skill.set: 2,
      Skill.agility: 2,
      Skill.receive: 2,
      Skill.serve: 2,
    },
  ),
  Player.withArgs(
    name: "Lucas (Matheus)",
    skills: {
      Skill.spike: 4,
      Skill.block: 3,
      Skill.set: 4,
      Skill.agility: 4,
      Skill.receive: 4,
      Skill.serve: 4,
    },
  ),
  Player.withArgs(
    name: "Maria",
    skills: {
      Skill.spike: 2,
      Skill.block: 0,
      Skill.set: 2,
      Skill.agility: 5,
      Skill.receive: 5,
      Skill.serve: 3,
    },
  ),
  Player.withArgs(
    name: "Matheus",
    skills: {
      Skill.spike: 3,
      Skill.block: 3,
      Skill.set: 3,
      Skill.agility: 4,
      Skill.receive: 4,
      Skill.serve: 4,
    },
  ),
  Player.withArgs(
    name: "Mis",
    skills: {
      Skill.spike: 2,
      Skill.block: 1,
      Skill.set: 2,
      Skill.agility: 2,
      Skill.receive: 3,
      Skill.serve: 2,
    },
  ),
  Player.withArgs(
    name: "Moises",
    skills: {
      Skill.spike: 3,
      Skill.block: 3,
      Skill.set: 3,
      Skill.agility: 3,
      Skill.receive: 3,
      Skill.serve: 3,
    },
  ),
  Player.withArgs(
    name: "Neto",
    skills: {
      Skill.spike: 4,
      Skill.block: 3,
      Skill.set: 4,
      Skill.agility: 3,
      Skill.receive: 4,
      Skill.serve: 4,
    },
  ),
  Player.withArgs(
    name: "PV",
    skills: {
      Skill.spike: 3,
      Skill.block: 2,
      Skill.set: 4,
      Skill.agility: 3,
      Skill.receive: 4,
      Skill.serve: 4,
    },
  ),
  Player.withArgs(
    name: "Rafaella",
    skills: {
      Skill.spike: 2,
      Skill.block: 1,
      Skill.set: 3,
      Skill.agility: 2,
      Skill.receive: 3,
      Skill.serve: 3,
    },
  ),
  Player.withArgs(
    name: "Ravi",
    skills: {
      Skill.spike: 3,
      Skill.block: 3,
      Skill.set: 2,
      Skill.agility: 2,
      Skill.receive: 1,
      Skill.serve: 3,
    },
  ),
  Player.withArgs(
    name: "Rodrigo",
    skills: {
      Skill.spike: 2,
      Skill.block: 1,
      Skill.set: 2,
      Skill.agility: 2,
      Skill.receive: 1,
      Skill.serve: 3,
    },
  ),
  Player.withArgs(
    name: "Saulo",
    skills: {
      Skill.spike: 3,
      Skill.block: 2,
      Skill.set: 2,
      Skill.agility: 3,
      Skill.receive: 3,
      Skill.serve: 2,
    },
  ),
  Player.withArgs(
    name: "Sylvia",
    skills: {
      Skill.spike: 2,
      Skill.block: 0,
      Skill.set: 2,
      Skill.agility: 1,
      Skill.receive: 2,
      Skill.serve: 2,
    },
  ),
  Player.withArgs(
    name: "Vini (Juca)",
    skills: {
      Skill.spike: 4,
      Skill.block: 2,
      Skill.set: 4,
      Skill.agility: 3,
      Skill.receive: 5,
      Skill.serve: 4,
    },
  ),
  Player.withArgs(
    name: "Vini (RedBull)",
    skills: {
      Skill.spike: 4,
      Skill.block: 4,
      Skill.set: 2,
      Skill.agility: 3,
      Skill.receive: 3,
      Skill.serve: 2,
    },
  ),
  Player.withArgs(
    name: "Vini Arciere",
    skills: {
      Skill.spike: 5,
      Skill.block: 5,
      Skill.set: 5,
      Skill.agility: 5,
      Skill.receive: 5,
      Skill.serve: 5,
    },
  ),
  Player.withArgs(
    name: "Vitoria",
    skills: {
      Skill.spike: 1,
      Skill.block: 1,
      Skill.set: 1,
      Skill.agility: 1,
      Skill.receive: 1,
      Skill.serve: 2,
    },
  ),
  Player.withArgs(
    name: "Wesley",
    skills: {
      Skill.spike: 3,
      Skill.block: 3,
      Skill.set: 3,
      Skill.agility: 4,
      Skill.receive: 3,
      Skill.serve: 3,
    },
  ),
];
