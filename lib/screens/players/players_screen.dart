import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voleizinho/bloc/player/players_bloc.dart';
import 'package:voleizinho/bloc/player/players_event.dart';
import 'package:voleizinho/bloc/player/players_state.dart';
import 'package:voleizinho/components/drawer.dart';
import 'package:voleizinho/components/edit_player_card.dart';
import 'package:voleizinho/components/menu_button.dart';
import 'package:voleizinho/components/player_card.dart';
import 'package:voleizinho/constants.dart';
import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/repositories/player_repository.dart';
import 'package:voleizinho/services/user_preferences.dart';

class PlayersScreen extends StatefulWidget {
  const PlayersScreen({super.key});

  @override
  State<PlayersScreen> createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  late PlayerRepository playerRepository = PlayerRepository();
  late List<Player> players = playerRepository.getPlayers();
  int groupId = UserPreferences.getGroup()!;

  int? editingPlayerIndex;
  int? deletingPlayerIndex;

  late Player newPlayer;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PlayersBloc>(context).add(PlayersLoadEvent(groupId));
  }

  void editingPlayer(int? index) {
    setState(() {
      editingPlayerIndex = index;
      deletingPlayerIndex = null;
    });
  }

  void deletingPlayer(int? index) {
    setState(() {
      deletingPlayerIndex = index;
      editingPlayerIndex = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlayersBloc, PlayersState>(
      listener: (context, state) {
        if (state.status == PlayersStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red[700],
              content: Text(
                state.errorMessage!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
        } else if (state.status == PlayersStatus.edited ||
            state.status == PlayersStatus.created) {
          setState(() {
            editingPlayerIndex = null;
            newPlayer = kDefaultPlayer.copyWith(name: "", groupId: groupId);
          });
        } else if (state.status == PlayersStatus.deleted) {
          setState(() {
            deletingPlayerIndex = null;
          });
        }
      },
      builder: (context, state) {
        if (state.status == PlayersStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Player> players = state.players;
        players.sort(
            (a, b) => a.name!.toUpperCase().compareTo(b.name!.toUpperCase()));
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
                    context
                        .read<PlayersBloc>()
                        .add(ImportPlayersEvent(groupId));
                  } else if (value == 1) {
                    context
                        .read<PlayersBloc>()
                        .add(ExportPlayersEvent(groupId));
                  } else if (value == 2) {
                    context
                        .read<PlayersBloc>()
                        .add(DeleteAllPlayersEvent(groupId));
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MenuButton(
                      text: "NOVO JOGADOR",
                      onPressed: () {
                        editingPlayer(-1);
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
                    if (editingPlayerIndex == -1)
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: EditPlayerCard(
                          player: newPlayer,
                          onCancel: () => editingPlayer(null),
                          onSave: (player) => context
                              .read<PlayersBloc>()
                              .add(CreatePlayerEvent(player)),
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
                                editingPlayerIndex != index
                                    ? GestureDetector(
                                        onHorizontalDragEnd: (details) =>
                                            setState(
                                          () {
                                            if (details.primaryVelocity! < 0) {
                                              deletingPlayer(index);
                                            } else {
                                              deletingPlayer(null);
                                            }
                                          },
                                        ),
                                        child: PlayerCard(
                                          player: players[index],
                                          hideDelete:
                                              deletingPlayerIndex != index,
                                          onPlayerDelete: () =>
                                              context.read<PlayersBloc>().add(
                                                    DeletePlayerEvent(
                                                      players[index],
                                                    ),
                                                  ),
                                          onPlayerTap: () =>
                                              editingPlayer(index),
                                        ),
                                      )
                                    : EditPlayerCard(
                                        player: Player.withArgs(
                                          name: players[index].name,
                                          skills: {...players[index].skills},
                                          groupId: groupId,
                                        ),
                                        onCancel: () => editingPlayer(null),
                                        onSave: (player) {
                                          player.id = players[index].id;
                                          context
                                              .read<PlayersBloc>()
                                              .add(EditPlayerEvent(player));
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
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
