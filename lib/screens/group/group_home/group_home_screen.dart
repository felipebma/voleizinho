import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voleizinho/bloc/group/groups_bloc.dart';
import 'package:voleizinho/components/menu_button.dart';
import 'package:voleizinho/model/group.dart';
import 'package:voleizinho/services/user_preferences/user_preferences.dart';

class GroupHomeScreen extends StatelessWidget {
  const GroupHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Group group = BlocProvider.of<GroupsBloc>(context).state.activeGroup!;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(image: AssetImage('assets/logo.png'), height: 200),
                const Text(
                  "VOLEIZINHO",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: "poller_one",
                  ),
                ),
                Text(
                  group.name!,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      fontFamily: "poller_one",
                      color: Colors.grey),
                ),
                const SizedBox(height: 50.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MenuButton(
                      leftWidget: const Icon(
                        Icons.man,
                        color: Colors.black,
                        size: 56,
                      ),
                      text: "Jogadores",
                      onPressed: () => {
                        Navigator.pushReplacementNamed(context, "/players"),
                      },
                    ),
                    MenuButton(
                      leftWidget: const Icon(
                        Icons.settings,
                        color: Colors.black,
                        size: 56,
                      ),
                      text: "Configurações",
                      onPressed: () => {
                        Navigator.pushReplacementNamed(context, "/settings"),
                      },
                    ),
                    MenuButton(
                      leftWidget: const Icon(
                        Icons.people,
                        color: Colors.black,
                        size: 56,
                      ),
                      text: "Times",
                      onPressed: () async {
                        UserPreferences.getTeams(group.id).then(
                          (value) {
                            if (value.isNotEmpty) {
                              Navigator.pushReplacementNamed(
                                  context, "/teams_view");
                            } else {
                              Navigator.pushReplacementNamed(
                                  context, "/team_creation");
                            }
                          },
                        );
                      },
                    ),
                    MenuButton(
                      leftWidget: const Icon(
                        Icons.scoreboard_outlined,
                        color: Colors.black,
                        size: 56,
                      ),
                      text: "Placar",
                      onPressed: () => {
                        Navigator.pushReplacementNamed(context, "/scoreboard"),
                      },
                    ),
                    MenuButton(
                      leftWidget: const Icon(
                        Icons.sync_alt_rounded,
                        color: Colors.black,
                        size: 56,
                      ),
                      text: "Alterar Grupo",
                      onPressed: () => {
                        Navigator.pushReplacementNamed(context, "/"),
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
