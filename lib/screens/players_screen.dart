import 'package:flutter/material.dart';
import 'package:voleizinho/components/menu_button.dart';
import 'package:voleizinho/components/new_player_form.dart';
import 'package:voleizinho/components/player_view.dart';
import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/model/skills.dart';

class PlayersScreen extends StatefulWidget {
  PlayersScreen({super.key, this.newPlayer = false});

  bool newPlayer;

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
    players.sort((a, b) => a.name.compareTo(b.name));
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
                        widget.newPlayer = true;
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
              if (widget.newPlayer)
                NewPlayerForm(
                    onCancel: () => setState(
                          () {
                            widget.newPlayer = false;
                          },
                        ),
                    onNewPlayer: (player) => setState(
                          () {
                            players.add(player);
                            widget.newPlayer = false;
                          },
                        ),
                    onSave: (player) => setState(
                          () {
                            widget.newPlayer = false;
                            players.add(player);
                          },
                        )),
              Expanded(
                child: ListView.builder(
                  itemCount: players.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          PlayerView(player: players[index]),
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
