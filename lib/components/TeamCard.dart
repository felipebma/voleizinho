import 'package:flutter/material.dart';
import 'package:voleizinho/components/player_team_view_card.dart';
import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/model/team.dart';

class TeamCard extends StatelessWidget {
  const TeamCard({
    super.key,
    required this.teamName,
    required this.team,
    required this.onPlayerSwitch,
    required this.onPlayerTap,
    required this.switchingPlayer,
  });

  final String teamName;
  final Team team;
  final void Function(Player) onPlayerSwitch;
  final void Function(Player) onPlayerTap;
  final Player? switchingPlayer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.red,
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  teamName,
                  style: const TextStyle(
                    fontFamily: "poller_one",
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                Text(team.getAverage().toStringAsFixed(2),
                    style: const TextStyle(
                      fontFamily: "poller_one",
                      color: Colors.black,
                      fontSize: 20,
                    )),
              ],
            ),
          ),
          for (Player player in team.getPlayers())
            Column(
              children: [
                PlayerTeamViewCard(
                    player: player,
                    onPlayerSwitch: onPlayerSwitch,
                    onPlayerTap: onPlayerTap,
                    showDetails: switchingPlayer == player),
              ],
            )
        ],
      ),
    );
  }
}
