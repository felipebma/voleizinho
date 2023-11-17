import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voleizinho/bloc/groups/group_bloc.dart';
import 'package:voleizinho/bloc/groups/group_states.dart';
import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/model/skills.dart';
import 'package:voleizinho/services/team_match_service.dart';

class SimilarPlayersList extends StatelessWidget {
  const SimilarPlayersList(
      {super.key, required this.player, required this.onPlayerSwitch});

  final Player player;
  final void Function(Player) onPlayerSwitch;

  @override
  Widget build(BuildContext context) {
    Map<Skill, int> skillsWeights =
        BlocProvider.of<GroupBloc>(context).state.activeGroup!.skillsWeights;
    return Column(
      children: [
        for (Player similarPlayer
            in TeamMatchService.getSimilarPlayers(player, skillsWeights)
                .take(5))
          Material(
            elevation: 3,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      similarPlayer.name!,
                      style: const TextStyle(
                        fontFamily: "poller_one",
                        color: Colors.blue,
                        fontSize: 10,
                      ),
                    ),
                    BlocBuilder<GroupBloc, GroupState>(
                        builder: (context, state) {
                      return Row(
                        children: [
                          Text(
                            "Similaridade: ${(100 * player.similarity(similarPlayer, state.activeGroup!.skillsWeights)).toStringAsFixed(0)}%",
                            style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Média: ${TeamMatchService.avgDiffOnSwap(player, similarPlayer, skillsWeights) > 0 ? "+" : ""}${TeamMatchService.avgDiffOnSwap(player, similarPlayer, skillsWeights).toStringAsFixed(2)}",
                            style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () => onPlayerSwitch(similarPlayer),
                            child: const Icon(Icons.change_circle),
                          ),
                        ],
                      );
                    })
                  ]),
            ),
          )
      ],
    );
  }
}
