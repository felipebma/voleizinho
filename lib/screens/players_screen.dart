import 'package:flutter/material.dart';
import 'package:voleizinho/components/edit_player_card.dart';
import 'package:voleizinho/components/menu_button.dart';
import 'package:voleizinho/components/player_card.dart';
import 'package:voleizinho/constants.dart';
import 'package:voleizinho/model/player.dart';

class PlayersScreen extends StatefulWidget {
  const PlayersScreen({super.key});

  @override
  State<PlayersScreen> createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  bool newPlayer = false;

  List<Player> players = playersDB;

  int editingPlayerIndex = -1;

  @override
  Widget build(BuildContext context) {
    players
        .sort((a, b) => a.name.toUpperCase().compareTo(b.name.toUpperCase()));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCDE8DE),
        elevation: 0,
        foregroundColor: Colors.black,
      ),
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
