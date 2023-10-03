import 'package:flutter/material.dart';
import 'package:voleizinho/components/player_view.dart';
import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/model/skills.dart';

class NewPlayerForm extends StatefulWidget {
  NewPlayerForm({
    super.key,
  });

  Player player = Player(
    name: "Jogador",
    skills: {
      Skill.spike: 2,
      Skill.agility: 2,
      Skill.block: 2,
      Skill.receive: 2,
      Skill.serve: 2,
      Skill.set: 2,
    },
  );

  void resetNewPlayer() {
    player = Player(
      name: "Jogador",
      skills: {
        Skill.spike: 2,
        Skill.agility: 2,
        Skill.block: 2,
        Skill.receive: 2,
        Skill.serve: 2,
        Skill.set: 2,
      },
    );
  }

  @override
  State<NewPlayerForm> createState() => _NewPlayerFormState();
}

class _NewPlayerFormState extends State<NewPlayerForm> {
  List<Widget> playerDetails(Player player) {
    List<Widget> widgets = [];

    for (Skill skill in Skill.values) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                skill.toShortString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                player.skills[skill].toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    Player player = Player(
      name: "Jogador",
      skills: {
        Skill.spike: 2,
        Skill.agility: 2,
        Skill.block: 2,
        Skill.receive: 2,
        Skill.serve: 2,
        Skill.set: 2,
      },
    );

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          PlayerView(
            player: player,
            editable: true,
          ),
          Material(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                ),
                child: Column(
                  children: [
                    ...playerDetails(player),
                    const Divider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.black,
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Cancelar",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.black,
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Salvar",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
