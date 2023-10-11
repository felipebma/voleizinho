import 'package:flutter/material.dart';
import 'package:voleizinho/components/menu_button.dart';
import 'package:voleizinho/components/player_team_view_card.dart';
import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/model/team.dart';
import 'package:voleizinho/screens/team_creation_screen.dart';
import 'package:voleizinho/services/team_match_service.dart';

class TeamsViewScreen extends StatefulWidget {
  const TeamsViewScreen({super.key});

  @override
  State<TeamsViewScreen> createState() => _TeamsViewScreenState();
}

class _TeamsViewScreenState extends State<TeamsViewScreen> {
  Player? switchingPlayer;

  void onPlayerSwitch(Player similarPlayer) {
    TeamMatchService.swapPlayers(switchingPlayer!, similarPlayer);
    setState(() {
      switchingPlayer = null;
    });
  }

  void onPlayerTap(Player player) {
    setState(() {
      switchingPlayer = switchingPlayer == player ? null : player;
    });
  }

  List<Team> teams = TeamMatchService.teams;

  @override
  Widget build(BuildContext context) {
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
                Navigator.pushReplacementNamed(context, '/team_creation',
                    arguments: TeamCreationScreenArguments(
                        teams
                            .map((e) => e.getPlayers())
                            .expand((element) => element)
                            .toList(),
                        teams[0].getPlayers().length));
              });
            },
            leftWidget:
                const Icon(color: Colors.black, Icons.keyboard_backspace_sharp),
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
                            PlayerTeamViewCard(
                                player: player,
                                onPlayerSwitch: onPlayerSwitch,
                                onPlayerTap: onPlayerTap,
                                showDetails: switchingPlayer == player),
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
