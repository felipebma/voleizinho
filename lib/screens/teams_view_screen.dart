import 'package:flutter/material.dart';
import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/model/team.dart';

class TeamsViewScreen extends StatefulWidget {
  const TeamsViewScreen({super.key});

  @override
  State<TeamsViewScreen> createState() => _TeamsViewScreenState();
}

class TeamsViewScreenArguments {
  TeamsViewScreenArguments({required this.teams});

  final List<Team> teams;
}

class _TeamsViewScreenState extends State<TeamsViewScreen> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as TeamsViewScreenArguments;

    List<Team> teams = args.teams;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCDE8DE),
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Center(
          child: Column(
        children: [
          for (Team team in teams)
            Padding(
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
                          'Time ${teams.indexOf(team) + 1}',
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
                    Text(
                      player.name!,
                      style: const TextStyle(
                        fontFamily: "poller_one",
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                ],
              ),
            ),
        ],
      )),
    );
  }
}
