import 'package:flutter/material.dart';
import 'package:share_screenshot_widget/share_screenshot_widget.dart';
import 'package:voleizinho/components/TeamCard.dart';
import 'package:voleizinho/components/drawer.dart';
import 'package:voleizinho/components/menu_button.dart';
import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/model/team.dart';
import 'package:voleizinho/screens/team_creation_screen.dart';
import 'package:voleizinho/services/share_service/share_service.dart';
import 'package:voleizinho/services/teams/team_service.dart';

class TeamsViewScreen extends StatefulWidget {
  const TeamsViewScreen({super.key});

  @override
  State<TeamsViewScreen> createState() => _TeamsViewScreenState();
}

class _TeamsViewScreenState extends State<TeamsViewScreen> {
  Player? switchingPlayer;
  List<Team> teams = TeamService.I.getTeams();
  List<GlobalKey> globalKeys = [];
  bool hideAverage = false;

  void onPlayerSwitch(Player similarPlayer) {
    TeamService.I.swapPlayers(switchingPlayer!, similarPlayer);
    setState(() {
      switchingPlayer = null;
    });
  }

  void onPlayerTap(Player player) {
    setState(() {
      switchingPlayer = switchingPlayer == player ? null : player;
    });
  }

  List<Widget> getTeamCards() {
    List<Widget> teamCards = [];
    for (int i = 0; i < teams.length; i++) {
      teamCards.add(
        ShareScreenshotAsImage(
          globalKey: globalKeys[i],
          child: GestureDetector(
            onTap: () => setState(
              () {
                hideAverage = !hideAverage;
              },
            ),
            child: TeamCard(
              teamName: "Time ${i + 1}",
              team: teams[i],
              onPlayerSwitch: onPlayerSwitch,
              onPlayerTap: onPlayerTap,
              switchingPlayer: switchingPlayer,
              hideAverage: hideAverage,
            ),
          ),
        ),
      );
    }
    return teamCards;
  }

  @override
  void initState() {
    super.initState();
    switchingPlayer = null;
    teams = TeamService.I.getTeams();
    if (teams.isEmpty) {
      Future.delayed(const Duration(milliseconds: 100)).then(
        (value) => Navigator.pushReplacementNamed(context, '/team_creation'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    globalKeys = teams.map((e) => GlobalKey()).toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCDE8DE),
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              MenuButton(
                text: "Selecionar Jogadores",
                onPressed: () {
                  setState(
                    () {
                      Navigator.pushReplacementNamed(
                        context,
                        '/team_creation',
                        arguments: TeamCreationScreenArguments(
                            teams
                                .map((e) => e.getPlayers())
                                .expand((element) => element)
                                .toList(),
                            teams[0].getPlayers().length),
                      );
                    },
                  );
                },
                leftWidget: const Icon(
                    color: Colors.black, Icons.keyboard_backspace_sharp),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: getTeamCards(),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => {
                  ShareService.shareWidgets(globalKeys),
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                ),
                child: const Text("Compartilhar Times"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
