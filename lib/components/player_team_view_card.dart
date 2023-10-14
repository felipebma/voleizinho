import 'package:flutter/material.dart';
import 'package:voleizinho/components/player_card.dart';
import 'package:voleizinho/components/similar_players_list.dart';
import 'package:voleizinho/model/player.dart';

class PlayerTeamViewCard extends StatelessWidget {
  const PlayerTeamViewCard({
    super.key,
    this.showDetails = false,
    required this.player,
    required this.onPlayerSwitch,
    required this.onPlayerTap,
  });

  final bool showDetails;
  final Player player;
  final void Function(Player) onPlayerSwitch;
  final void Function(Player) onPlayerTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => onPlayerTap(player),
          child: PlayerCard(
            onPlayerTap: () => onPlayerTap(player),
            player: player,
            hideAverage: true,
          ),
        ),
        if (showDetails)
          SimilarPlayersList(
            player: player,
            onPlayerSwitch: (Player similarPlayer) =>
                onPlayerSwitch(similarPlayer),
          ),
      ],
    );
  }
}
