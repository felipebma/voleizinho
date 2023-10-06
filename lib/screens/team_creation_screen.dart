import 'dart:math';

import 'package:flutter/material.dart';
import 'package:voleizinho/components/player_card.dart';
import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/repositories/player_repository.dart';
import 'package:voleizinho/screens/teams_view_screen.dart';
import 'package:voleizinho/services/team_match_service.dart';

class TeamCreationScreen extends StatefulWidget {
  const TeamCreationScreen({super.key});

  @override
  State<TeamCreationScreen> createState() => _TeamCreationScreenState();
}

class _TeamCreationScreenState extends State<TeamCreationScreen> {
  late PlayerRepository playerRepository = PlayerRepository();
  late List<Player> players = PlayerRepository.getPlayers();

  List<Player> selectedPlayers = [];

  @override
  void initState() {
    super.initState();
    refreshPlayers();
  }

  void refreshPlayers() {
    setState(() {
      players = PlayerRepository.getPlayers();
    });
  }

  int playersPerTeam = 0;
  int minPlayersPerTeam = 0;
  int maxPlayersPerTeam = 0;

  void selectPlayer(Player player) {
    setState(() {
      if (selectedPlayers.contains(player)) {
        selectedPlayers.remove(player);
      } else {
        selectedPlayers.add(player);
      }
      minPlayersPerTeam = min(selectedPlayers.length ~/ 2, 2);
      maxPlayersPerTeam = selectedPlayers.length ~/ 2;
      if (playersPerTeam < minPlayersPerTeam) {
        playersPerTeam = min(selectedPlayers.length ~/ 2, 2);
      }
      if (playersPerTeam > maxPlayersPerTeam) {
        playersPerTeam = maxPlayersPerTeam;
      }
    });
  }

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    DropdownMenu<int>(
                      menuStyle: const MenuStyle(alignment: Alignment.center),
                      onSelected: (value) => setState(() {
                        playersPerTeam = value!;
                      }),
                      initialSelection: playersPerTeam,
                      dropdownMenuEntries: List.generate(
                        maxPlayersPerTeam - minPlayersPerTeam + 1,
                        (index) => DropdownMenuEntry(
                          label:
                              "${index + minPlayersPerTeam} jogadores por time",
                          value: index + minPlayersPerTeam,
                        ),
                      ),
                    ),
                  ],
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/teams_view",
                        arguments: TeamsViewScreenArguments(
                            teams: TeamMatchService.createTeams(
                                selectedPlayers, playersPerTeam)));
                  },
                  child: const Text(
                    "Criar Times",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
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
                        GestureDetector(
                          onTap: () {
                            setState(() => selectPlayer(players[index]));
                          },
                          child: PlayerCard(
                            player: players[index],
                            color: selectedPlayers.contains(players[index])
                                ? Colors.green
                                : Colors.white,
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                          height: 1,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
