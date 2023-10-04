enum Skill {
  set,
  spike,
  block,
  serve,
  receive,
  agility,
}

extension ParseToString on Skill {
  String toShortString() {
    switch (this) {
      case Skill.set:
        return "LEVANTAMENTO";
      case Skill.spike:
        return "ATAQUE";
      case Skill.block:
        return "BLOQUEIO";
      case Skill.serve:
        return "SAQUE";
      case Skill.receive:
        return "RECEPÇÃO";
      case Skill.agility:
        return "MOVIMENTAÇÃO";
    }
  }
}
