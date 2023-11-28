import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voleizinho/bloc/team/teams_bloc.dart';
import 'package:voleizinho/bloc/team/teams_state.dart';
import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/model/similar_player.dart';

class SimilarPlayersList extends StatelessWidget {
  const SimilarPlayersList(
      {super.key, required this.player, required this.onPlayerSwitch});

  final Player player;
  final void Function(Player) onPlayerSwitch;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamsBloc, TeamsState>(
      builder: (context, state) {
        if (state.status == TeamsStatus.loading ||
            state.similarPlayers.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.status == TeamsStatus.error) {
          return const Center(
            child: Text("Erro ao carregar jogadores"),
          );
        }
        return Column(
          children: [
            for (SimilarPlayer similarPlayer in state.similarPlayers.take(5))
              Material(
                elevation: 3,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          similarPlayer.player.name!,
                          style: const TextStyle(
                            fontFamily: "poller_one",
                            color: Colors.blue,
                            fontSize: 10,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Similaridade: ${(100 * similarPlayer.similarity).toStringAsFixed(0)}%",
                              style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Média: ${similarPlayer.avgDiff > 0 ? "+" : ""}${similarPlayer.avgDiff.toStringAsFixed(2)}",
                              style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () => onPlayerSwitch(similarPlayer.player),
                              child: const Icon(Icons.change_circle),
                            ),
                          ],
                        )
                      ]),
                ),
              )
          ],
        );
      },
    );
  }
}
