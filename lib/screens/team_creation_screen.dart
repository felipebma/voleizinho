import 'package:flutter/material.dart';
import 'package:voleizinho/components/player_card.dart';
import 'package:voleizinho/constants.dart';
import 'package:voleizinho/model/player.dart';

class TeamCreationScreen extends StatefulWidget {
  const TeamCreationScreen({super.key});

  @override
  State<TeamCreationScreen> createState() => _TeamCreationScreenState();
}

class _TeamCreationScreenState extends State<TeamCreationScreen> {
  List<Player> players = playersDB;
  List<Player> selectedPlayers = [];

  int playersPerTeam = 6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCDE8DE),
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: players.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (selectedPlayers.contains(players[index])) {
                                selectedPlayers.remove(players[index]);
                              } else {
                                selectedPlayers.add(players[index]);
                              }
                            });
                          },
                          child: PlayerCard(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
