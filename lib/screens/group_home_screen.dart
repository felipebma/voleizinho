import 'package:flutter/material.dart';
import 'package:voleizinho/components/menu_button.dart';
import 'package:voleizinho/services/user_preferences.dart';

class GroupMainScreenArguments {
  GroupMainScreenArguments({required this.groupId, required this.groupName});

  int groupId;
  String groupName;
}

class GroupHomeScreen extends StatelessWidget {
  const GroupHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GroupMainScreenArguments args =
        ModalRoute.of(context)!.settings.arguments as GroupMainScreenArguments;
    UserPreferences.setGroup(args.groupId);
    String groupName = args.groupName;

    return Scaffold(
      body: SafeArea(
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
                groupName,
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
                      Navigator.pushNamed(context, "/players"),
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
                      Navigator.pushNamed(context, "/settings"),
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
                      UserPreferences.getTeams().then(
                        (value) {
                          if (value.isNotEmpty) {
                            Navigator.pushNamed(context, "/teams_view");
                          } else {
                            Navigator.pushNamed(context, "/team_creation");
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
                      Navigator.pushNamed(context, "/scoreboard"),
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
    );
  }
}