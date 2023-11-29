import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voleizinho/bloc/group/groups_bloc.dart';
import 'package:voleizinho/bloc/player/players_bloc.dart';
import 'package:voleizinho/bloc/player/players_event.dart';
import 'package:voleizinho/bloc/team/teams_bloc.dart';
import 'package:voleizinho/bloc/team/teams_event.dart';
import 'package:voleizinho/bloc/team/teams_state.dart';
import 'package:voleizinho/components/drawer.dart';
import 'package:voleizinho/components/error_snackbar.dart';
import 'package:voleizinho/screens/teams/teams_creation/components/player_list.dart';

class TeamCreationScreen extends StatefulWidget {
  const TeamCreationScreen({super.key});

  @override
  State<TeamCreationScreen> createState() => _TeamCreationScreenState();
}

class _TeamCreationScreenState extends State<TeamCreationScreen> {
  @override
  void initState() {
    super.initState();
    int groupId = BlocProvider.of<GroupsBloc>(context).state.activeGroup!.id;
    BlocProvider.of<PlayersBloc>(context).add(
      PlayersLoadEvent(groupId),
    );
    BlocProvider.of<TeamsBloc>(context).add(
      LoadSelectedPlayers(groupId),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            {
              Navigator.pushReplacementNamed(context, "/teams_view"),
            }
          else if (state.status == TeamsStatus.error)
            {
              ScaffoldMessenger.of(context).showSnackBar(
                ErrorSnackbar(content: state.errorMessage!),
              ),
            }
        },
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BlocBuilder<TeamsBloc, TeamsState>(
                      builder: (context, state) => DropdownMenu<int>(
                        menuStyle: const MenuStyle(alignment: Alignment.center),
                        onSelected: (value) => context
                            .read<TeamsBloc>()
                            .add(SetPlayersPerTeam(value!)),
                        initialSelection: state.playersPerTeam,
                        dropdownMenuEntries: List.generate(
                          state.maxPlayersPerTeam - state.minPlayersPerTeam + 1,
                          (index) => DropdownMenuEntry(
                            label:
                                "${index + state.minPlayersPerTeam} jogadores por time",
                            value: index + state.minPlayersPerTeam,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () => {
                        BlocProvider.of<TeamsBloc>(context).add(
                          CreateTeams(BlocProvider.of<GroupsBloc>(context)
                              .state
                              .activeGroup!
                              .id),
                        ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<TeamsBloc, TeamsState>(
                        builder: (context, state) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Jogadores Selecionados: ${state.selectedPlayers.length}",
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: ElevatedButton(
                        onPressed: () => {
                          context.read<TeamsBloc>().add(UnselectAllPlayers()),
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
                const Expanded(
                  child: PlayerList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
