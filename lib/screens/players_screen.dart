import 'package:flutter/material.dart';
import 'package:voleizinho/components/edit_player_card.dart';
import 'package:voleizinho/components/menu_button.dart';
import 'package:voleizinho/components/player_card.dart';
import 'package:voleizinho/constants.dart';
import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/repositories/player_repository.dart';
import 'package:voleizinho/shared_pref.dart';

class PlayersScreen extends StatefulWidget {
  const PlayersScreen({super.key});

  @override
  State<PlayersScreen> createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  late List<Player> players = [];

  SharedPref pref = SharedPref();

  @override
  void initState() {
    super.initState();
    refreshPlayers();
  }

  void refreshPlayers() {
    // PlayerRepository.resetDB();
    pref.read("players").then((value) {
      setState(() {
        players = SharedPref.decode(value);
      });
    });
  }

  int? editingPlayerIndex;
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
                        editingPlayerIndex = -1;
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
              if (editingPlayerIndex == -1)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: EditPlayerCard(
                      player: kDefaultPlayer.copyWith(),
                      onCancel: () => setState(
                            () {
                              editingPlayerIndex = null;
                            },
                          ),
                      onSave: (player) => setState(
                            () {
                              editingPlayerIndex = null;
                              PlayerRepository.addPlayer(player);
                              players.add(player);
                            },
                          )),
                ),
              const SizedBox(
                height: 30,
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
                                  player: Player(
                                    name: players[index].name,
                                    skills: {...players[index].skills},
                                  ),
                                  onCancel: () => setState(
                                    () {
                                      editingPlayerIndex = null;
                                    },
                                  ),
                                  onSave: (player) => setState(
                                    () {
                                      editingPlayerIndex = null;
                                      PlayerRepository.updatePlayer(
                                          players[index], player);
                                      players[index] = player;
                                    },
                                  ),
                                ),
                          const Divider(
                            height: 5,
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
