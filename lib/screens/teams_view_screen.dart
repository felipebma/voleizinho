import 'package:flutter/material.dart';
import 'package:voleizinho/components/menu_button.dart';
import 'package:voleizinho/components/player_card.dart';
import 'package:voleizinho/components/similar_players_list.dart';
import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/model/team.dart';
import 'package:voleizinho/services/team_match_service.dart';

class TeamsViewScreen extends StatefulWidget {
  const TeamsViewScreen({super.key});

  @override
  State<TeamsViewScreen> createState() => _TeamsViewScreenState();
}

class TeamsViewScreenArguments {
  TeamsViewScreenArguments({required this.teams});

  final List<Team> teams;
}

class _TeamsViewScreenState extends State<TeamsViewScreen> {
  Player? switchingPlayer;
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as TeamsViewScreenArguments;

    List<Team> teams = args.teams;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCDE8DE),
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Center(
          child: Column(
        children: [
          MenuButton(
            text: "Selecionar Jogadores",
            onPressed: () {
              setState(() {
                Navigator.pushReplacementNamed(context, '/team_creation');
              });
            },
            leftWidget: Container(
              child: const Icon(
                  color: Colors.black, Icons.keyboard_backspace_sharp),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: teams.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Time ${index + 1}',
                              style: const TextStyle(
                                fontFamily: "poller_one",
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            Text(teams[index].getAverage().toStringAsFixed(2),
                                style: const TextStyle(
                                  fontFamily: "poller_one",
                                  color: Colors.black,
                                  fontSize: 20,
                                )),
                          ],
                        ),
                      ),
                      for (Player player in teams[index].getPlayers())
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (switchingPlayer == player) {
                                    switchingPlayer = null;
                                  } else {
                                    switchingPlayer = player;
                                  }
                                });
                              },
                              child: PlayerCard(
                                player: player,
                                hideAverage: true,
                              ),
                            ),
                            if (switchingPlayer == player)
                              SimilarPlayersList(
                                player: player,
                                onPlayerSwitch: (Player similarPlayer) => {
                                  TeamMatchService.swapPlayers(
                                      player, similarPlayer),
                                  setState(() {
                                    switchingPlayer = null;
                                    teams = TeamMatchService.teams;
                                  })
                                },
                              ),
                          ],
                        )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}
