import 'package:flutter/material.dart';
import 'package:voleizinho/components/player_card.dart';
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
          for (Team team in teams)
            Padding(
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
                          'Time ${teams.indexOf(team) + 1}',
                          style: const TextStyle(
                            fontFamily: "poller_one",
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        Text(team.getAverage().toStringAsFixed(2),
                            style: const TextStyle(
                              fontFamily: "poller_one",
                              color: Colors.black,
                              fontSize: 20,
                            )),
                      ],
                    ),
                  ),
                  for (Player player in team.getPlayers())
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
                          Column(
                            children: [
                              for (Player similarPlayer
                                  in TeamMatchService.getSimilarPlayers(player)
                                      .take(3))
                                Material(
                                  elevation: 3,
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            similarPlayer.name!,
                                            style: const TextStyle(
                                              fontFamily: "poller_one",
                                              color: Colors.blue,
                                              fontSize: 10,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Similaridade: ${(100 * player.similarity(similarPlayer)).toStringAsFixed(0)}%",
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                "Média: ${TeamMatchService.avgDiffOnSwap(player, similarPlayer) > 0 ? "+" : ""}${TeamMatchService.avgDiffOnSwap(player, similarPlayer).toStringAsFixed(2)}",
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              GestureDetector(
                                                onTap: () => {
                                                  TeamMatchService.swapPlayers(
                                                      player, similarPlayer),
                                                  setState(() {
                                                    switchingPlayer = null;
                                                    teams =
                                                        TeamMatchService.teams;
                                                  })
                                                },
                                                child: const Icon(
                                                    Icons.change_circle),
                                              ),
                                            ],
                                          )
                                        ]),
                                  ),
                                )
                            ],
                          ),
                      ],
                    )
                ],
              ),
            ),
        ],
      )),
    );
  }
}
