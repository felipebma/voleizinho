import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:voleizinho/components/drawer.dart';
import 'package:voleizinho/components/player_card.dart';
import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/services/player_service.dart';
import 'package:voleizinho/services/team_match_service.dart';
import 'package:voleizinho/services/user_preferences.dart';

class TeamCreationScreen extends StatefulWidget {
  const TeamCreationScreen({super.key});

  @override
  State<TeamCreationScreen> createState() => _TeamCreationScreenState();
}

class TeamCreationScreenArguments {
  List<Player> selectedPlayers = [];
  int playersPerTeam = 0;

  TeamCreationScreenArguments(this.selectedPlayers, this.playersPerTeam);
}

class _TeamCreationScreenState extends State<TeamCreationScreen> {
  late List<Player> players =
      PlayerService.getPlayersFromGroup(UserPreferences.getGroup()!);

  List<Player> selectedPlayers = [];

  int playersPerTeam = 0;
  int minPlayersPerTeam = 0;
  int maxPlayersPerTeam = 0;

  @override
  void initState() {
    super.initState();
    refreshPlayers();
  }

  void processArguments(context) {
    final TeamCreationScreenArguments args =
        (ModalRoute.of(context)!.settings.arguments ??
            TeamCreationScreenArguments([], 0)) as TeamCreationScreenArguments;
    if (args.selectedPlayers.isEmpty) return;
    for (var element in args.selectedPlayers) {
      setState(() {
        Player? player = players
            .firstWhereOrNull((element2) => element2.name == element.name);
        if (player != null) {
          selectPlayer(player);
        }
      });
    }
    setState(() {
      playersPerTeam = args.playersPerTeam;
    });
    args.selectedPlayers = [];
  }

  void createTeams() async {
    if (playersPerTeam < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red[700],
          content: const Text(
            "Você deve selecionar pelo menos 2 jogadores por time!",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      );
      return;
    }
    await TeamMatchService.createTeams(selectedPlayers, playersPerTeam);

    while (!context.mounted) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    if (context.mounted) Navigator.pushReplacementNamed(context, "/teams_view");
  }

  void refreshPlayers() {
    setState(() {
      players = PlayerService.getPlayersFromGroup(UserPreferences.getGroup()!);
      players.sort(
          (a, b) => a.name!.toUpperCase().compareTo(b.name!.toUpperCase()));
    });
  }

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
    processArguments(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCDE8DE),
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Center(
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
                    onPressed: () => createTeams(),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Jogadores Selecionados: ${selectedPlayers.length}",
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: ElevatedButton(
                      onPressed: () => {
                        setState(() {
                          selectedPlayers = [];
                          playersPerTeam = 0;
                        })
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red)),
                      child: const Text("Limpar Seleção"),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
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
                              onPlayerTap: () => selectPlayer(players[index]),
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
      ),
    );
  }
}
