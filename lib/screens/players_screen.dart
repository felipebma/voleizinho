import 'package:flutter/material.dart';
import 'package:voleizinho/components/menu_button.dart';
import 'package:voleizinho/components/player_view.dart';
import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/model/skills.dart';

class PlayersScreen extends StatefulWidget {
  const PlayersScreen({super.key});

  @override
  State<PlayersScreen> createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  List<Player> players = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MenuButton(
                  text: "NOVO JOGADOR",
                  onPressed: () {},
                  leftWidget: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.green,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 56,
                    ),
                  )),
              const Text("Jogadores"),
              Expanded(
                child: ListView.builder(
                  itemCount: players.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        PlayerView(player: players[index]),
                        const Divider(
                          height: 1,
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
