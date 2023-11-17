import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voleizinho/bloc/groups/group_bloc.dart';
import 'package:voleizinho/bloc/players/players_bloc.dart';
import 'package:voleizinho/bloc/players/players_events.dart';
import 'package:voleizinho/bloc/players/players_states.dart';
import 'package:voleizinho/components/edit_player_card.dart';
import 'package:voleizinho/components/player_card.dart';
import 'package:voleizinho/model/player.dart';

class PlayersList extends StatefulWidget {
  const PlayersList({super.key, required this.players});

  final List<Player> players;

  @override
  State<PlayersList> createState() => _PlayersListState();
}

class _PlayersListState extends State<PlayersList> {
  @override
  Widget build(BuildContext context) {
    PlayersBloc bloc = BlocProvider.of<PlayersBloc>(context);
    int groupId = BlocProvider.of<GroupBloc>(context).state.activeGroup!.id;
    PlayersState state = bloc.state;

    return Expanded(
      child: ListView.builder(
        itemCount: widget.players.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                state.editingPlayerIndex != index
                    ? GestureDetector(
                        onHorizontalDragEnd: (details) => bloc.add(
                          PlayersDeletingEvent(
                            details.primaryVelocity! < 0 ? index : null,
                          ),
                        ),
                        child: PlayerCard(
                          player: widget.players[index],
                          hideDelete: bloc.state.deletingPlayerIndex != index,
                          onPlayerDelete: () => bloc.add(
                            PlayersDeleteEvent(widget.players[index]),
                          ),
                          onPlayerTap: () =>
                              bloc.add(PlayersEditingEvent(index)),
                        ),
                      )
                    : EditPlayerCard(
                        player: Player.withArgs(
                          name: widget.players[index].name,
                          skills: {...widget.players[index].skills},
                          groupId: groupId,
                        ),
                        onCancel: () => bloc.add(PlayersEditingEvent(-2)),
                        onSave: (player) => {
                          player.id = widget.players[index].id,
                          bloc.add(PlayersEditEvent(player, index))
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
    );
  }
}
