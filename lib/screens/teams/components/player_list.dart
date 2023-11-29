import 'package:flutter/material.dart';
import 'package:voleizinho/components/player_card.dart';
import 'package:voleizinho/model/player.dart';

class PlayerList extends StatelessWidget {
  const PlayerList(
      {super.key,
      required this.players,
      required this.selectPlayer,
      required this.selectedPlayers});

  final void Function(Player player) selectPlayer;
  final List<Player> players;
  final List<Player> selectedPlayers;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: players.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => selectPlayer(players[index]),
                child: PlayerCard(
                  onPlayerTap: () => selectPlayer(players[index]),
                  player: players[index],
                  color: selectedPlayers.contains(players[index])
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
      },
    );
  }
}
