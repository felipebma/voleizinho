import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voleizinho/bloc/players/players_bloc.dart';
import 'package:voleizinho/bloc/players/players_events.dart';
import 'package:voleizinho/bloc/players/players_states.dart';
import 'package:voleizinho/components/drawer.dart';
import 'package:voleizinho/components/edit_player_card.dart';
import 'package:voleizinho/components/menu_button.dart';
import 'package:voleizinho/components/player_card.dart';
import 'package:voleizinho/constants.dart';
import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/services/user_preferences.dart';

class PlayersScreen extends StatefulWidget {
  const PlayersScreen({super.key});

  @override
  State<PlayersScreen> createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  int groupId = UserPreferences.getGroup()!;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PlayersBloc>(context).add(PlayersLoadEvent(groupId));
  }

  @override
  Widget build(BuildContext context) {
    PlayersBloc bloc = BlocProvider.of<PlayersBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCDE8DE),
        elevation: 0,
        foregroundColor: Colors.black,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: 0,
                  child: Text("Importar Jogadores"),
                ),
                const PopupMenuItem(
                  value: 1,
                  child: Text("Exportar Jogadores"),
                ),
                const PopupMenuItem(
                  value: 2,
                  child: Text("Apagar Jogadores"),
                )
              ];
            },
            onSelected: (value) {
              if (value == 0) {
                bloc.add(PlayersImportEvent(groupId));
              } else if (value == 1) {
                bloc.add(PlayersExportEvent(groupId));
              } else if (value == 2) {
                bloc.add(PlayersClearEvent(groupId));
              }
            },
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Center(
            child: BlocConsumer<PlayersBloc, PlayersState>(
                listener: (context, state) {
              if (state.isError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage!),
                  ),
                );
              }
            }, builder: (context, state) {
              final players = state.players;
              players.sort((a, b) =>
                  a.name!.toUpperCase().compareTo(b.name!.toUpperCase()));
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MenuButton(
                    text: "NOVO JOGADOR",
                    onPressed: () {
                      bloc.add(PlayersEditingEvent(-1));
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
                    ),
                  ),
                  MenuButton(
                    text: "CRIAR TIMES",
                    onPressed: () {
                      setState(() {
                        Navigator.pushReplacementNamed(
                            context, '/team_creation');
                      });
                    },
                    leftWidget: const Icon(
                      color: Colors.black,
                      Icons.group_rounded,
                      size: 30,
                    ),
                  ),
                  if (state.editingPlayerIndex == -1)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: EditPlayerCard(
                        player:
                            kDefaultPlayer.copyWith(name: "", groupId: groupId),
                        onCancel: () => bloc.add(PlayersEditingEvent(-2)),
                        onSave: (player) =>
                            bloc.add(PlayersCreateEvent(player)),
                      ),
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
                              state.editingPlayerIndex != index
                                  ? GestureDetector(
                                      onHorizontalDragEnd: (details) =>
                                          setState(
                                        () {
                                          bloc.add(PlayersDeletingEvent(
                                            details.primaryVelocity! < 0
                                                ? index
                                                : null,
                                          ));
                                        },
                                      ),
                                      child: PlayerCard(
                                        player: players[index],
                                        hideDelete:
                                            bloc.state.deletingPlayerIndex !=
                                                index,
                                        onPlayerDelete: () => bloc.add(
                                          PlayersDeleteEvent(players[index]),
                                        ),
                                        onPlayerTap: () => bloc
                                            .add(PlayersEditingEvent(index)),
                                      ),
                                    )
                                  : EditPlayerCard(
                                      player: Player.withArgs(
                                        name: players[index].name,
                                        skills: {...players[index].skills},
                                        groupId: groupId,
                                      ),
                                      onCancel: () =>
                                          bloc.add(PlayersEditingEvent(-2)),
                                      onSave: (player) => {
                                        player.id = players[index].id,
                                        bloc.add(
                                            PlayersEditEvent(player, index))
                                      },
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
              );
            }),
          ),
        ),
      ),
    );
  }
}
