import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voleizinho/bloc/player/players_bloc.dart';
import 'package:voleizinho/bloc/player/players_state.dart';
import 'package:voleizinho/bloc/team/teams_bloc.dart';
import 'package:voleizinho/bloc/team/teams_event.dart';
import 'package:voleizinho/bloc/team/teams_state.dart';
import 'package:voleizinho/components/player_card.dart';
import 'package:voleizinho/model/player.dart';

class PlayerList extends StatefulWidget {
  const PlayerList({
    super.key,
  });

  @override
  State<PlayerList> createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerList> {
  List<Player> players = [];

  Widget _buildPlayerList(BuildContext context) {
    return BlocBuilder<TeamsBloc, TeamsState>(
      builder: (context, state) {
        return ListView.builder(
            itemCount: players.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => context
                          .read<TeamsBloc>()
                          .add(SelectPlayer(players[index])),
                      child: PlayerCard(
                        onPlayerTap: () => context
                            .read<TeamsBloc>()
                            .add(SelectPlayer(players[index])),
                        player: players[index],
                        color: state.selectedPlayers
                                .any((player) => player.id == players[index].id)
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
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayersBloc, PlayersState>(
      builder: (context, state) {
        if (state.status == PlayersStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.status == PlayersStatus.error) {
          return const Center(
            child: Text(
                "Ocorreu um erro, não foi possível carregar os jogadores!"),
          );
        }
        players = state.players;
        players.sort((a, b) => a.name!.compareTo(b.name!));
        return _buildPlayerList(context);
      },
    );
  }
}
