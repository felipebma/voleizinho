import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_screenshot_widget/share_screenshot_widget.dart';
import 'package:voleizinho/bloc/group/groups_bloc.dart';
import 'package:voleizinho/bloc/team/teams_bloc.dart';
import 'package:voleizinho/bloc/team/teams_event.dart';
import 'package:voleizinho/bloc/team/teams_state.dart';
import 'package:voleizinho/screens/teams/teams_view/components/team_card.dart';
import 'package:voleizinho/components/drawer.dart';
import 'package:voleizinho/components/error_snackbar.dart';
import 'package:voleizinho/components/menu_button.dart';
import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/model/team.dart';
import 'package:voleizinho/services/share_service/share_service.dart';

class TeamsViewScreen extends StatefulWidget {
  const TeamsViewScreen({super.key});

  @override
  State<TeamsViewScreen> createState() => _TeamsViewScreenState();
}

class _TeamsViewScreenState extends State<TeamsViewScreen> {
  List<GlobalKey> globalKeys = [];
  bool hideAverage = true;

  void onPlayerSwitch(Player similarPlayer) {
    int groupId = BlocProvider.of<GroupsBloc>(context).state.activeGroup!.id;
    context.read<TeamsBloc>().add(
          SwapPlayers(groupId, similarPlayer),
        );
  }

  List<Widget> getTeamCards(List<Team> teams) {
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
              onPlayerTap: (player) =>
                  context.read<TeamsBloc>().add(SelectPlayerToSwitch(player)),
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
    int groupId = BlocProvider.of<GroupsBloc>(context).state.activeGroup!.id;
    BlocProvider.of<TeamsBloc>(context).add(LoadTeams(groupId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeamsBloc, TeamsState>(
      listener: (context, state) => {
        if (state.status == TeamsStatus.error)
          {
            ScaffoldMessenger.of(context).showSnackBar(
              ErrorSnackbar(content: state.errorMessage!),
            ),
          }
        else if (state.status == TeamsStatus.loaded && state.teams.isEmpty)
          {Navigator.pushReplacementNamed(context, '/team_creation')}
      },
      builder: (context, state) {
        if (state.status == TeamsStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Team> teams = state.teams;
        globalKeys = teams.map((e) => GlobalKey()).toList();
        return Center(
          child: Scaffold(
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
                          children: getTeamCards(teams),
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
          ),
        );
      },
    );
  }
}
