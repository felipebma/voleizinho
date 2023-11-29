import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voleizinho/bloc/group/groups_bloc.dart';
import 'package:voleizinho/bloc/team/teams_bloc.dart';
import 'package:voleizinho/bloc/team/teams_event.dart';
import 'package:voleizinho/bloc/team/teams_state.dart';
import 'package:voleizinho/components/drawer.dart';
import 'package:voleizinho/components/error_snackbar.dart';
import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/screens/teams/components/player_list.dart';
import 'package:voleizinho/services/players/player_service.dart';
import 'package:voleizinho/services/user_preferences/user_preferences.dart';

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
  PlayerService playerService = PlayerService.getInstance();

  late List<Player> players =
      playerService.getPlayersFromGroup(UserPreferences.getGroup()!);

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
        ErrorSnackbar(
            content: "Você deve selecionar pelo menos 2 jogadores por time!"),
      );
      return;
    }
    int groupId = BlocProvider.of<GroupsBloc>(context).state.activeGroup!.id;
    BlocProvider.of<TeamsBloc>(context)
        .add(CreateTeams(groupId, selectedPlayers, playersPerTeam));
  }

  void refreshPlayers() {
    setState(() {
      players = playerService.getPlayersFromGroup(UserPreferences.getGroup()!);
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
      body: BlocListener<TeamsBloc, TeamsState>(
        listener: (context, state) => {
          if (state.status == TeamsStatus.created)
            {Navigator.pushReplacementNamed(context, "/teams_view")}
        },
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        DropdownMenu<int>(
                          menuStyle:
                              const MenuStyle(alignment: Alignment.center),
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
                  child: PlayerList(
                    players: players,
                    selectPlayer: selectPlayer,
                    selectedPlayers: selectedPlayers,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
