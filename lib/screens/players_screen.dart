import 'package:flutter/material.dart';
import 'package:voleizinho/components/edit_player_card.dart';
import 'package:voleizinho/components/menu_button.dart';
import 'package:voleizinho/components/player_card.dart';
import 'package:voleizinho/constants.dart';
import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/model/skills.dart';

class PlayersScreen extends StatefulWidget {
  const PlayersScreen({super.key});

  @override
  State<PlayersScreen> createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  bool newPlayer = false;

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

  int editingPlayerIndex = -1;

  @override
  Widget build(BuildContext context) {
    players
        .sort((a, b) => a.name.toUpperCase().compareTo(b.name.toUpperCase()));
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: MenuButton(
                    text: "NOVO JOGADOR",
                    onPressed: () {
                      setState(() {
                        newPlayer = true;
                      });
                    },
                    leftWidget: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.green,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      ),
                    )),
              ),
              if (newPlayer)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: EditPlayerCard(
                      player: kDefaultPlayer,
                      onCancel: () => setState(
                            () {
                              newPlayer = false;
                            },
                          ),
                      onSave: (player) => setState(
                            () {
                              newPlayer = false;
                              players.add(player);
                            },
                          )),
                ),
              Expanded(
                child: ListView.builder(
                  itemCount: players.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          editingPlayerIndex != index
                              ? GestureDetector(
                                  onTap: () => setState(
                                    () {
                                      editingPlayerIndex = index;
                                    },
                                  ),
                                  child: PlayerCard(
                                    player: players[index],
                                  ),
                                )
                              : EditPlayerCard(
                                  player: kDefaultPlayer.copyWith(
                                    name: players[index].name,
                                    skills: players[index].skills,
                                  ),
                                  onCancel: () => setState(
                                    () {
                                      editingPlayerIndex = -1;
                                    },
                                  ),
                                  onSave: (player) => setState(
                                    () {
                                      editingPlayerIndex = -1;
                                      players[index] = player;
                                    },
                                  ),
                                ),
                          const Divider(
                            height: 1,
                          )
                        ],
                      ),
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
