import 'package:flutter/material.dart';
import 'package:voleizinho/services/group_service.dart';
import 'package:voleizinho/services/user_preferences.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Center(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            if (MediaQuery.of(context).orientation == Orientation.portrait)
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xFFCDE8DE),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      UserPreferences.getGroup() == null
                          ? "Voleizinho"
                          : GroupService.activeGroup().name!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: "poller_one",
                      ),
                    ),
                  ],
                ),
              ),
            const DrawerTile(
                text: "Menu Principal", icon: Icons.menu, route: "/main_group"),
            const DrawerTile(
                text: "Jogadores", icon: Icons.person, route: "/players"),
            const DrawerTile(
                text: "Times", icon: Icons.group, route: "/teams_view"),
            const DrawerTile(
                text: "Configurações",
                icon: Icons.settings,
                route: "/settings"),
            const DrawerTile(
                text: "Placar",
                icon: Icons.scoreboard_outlined,
                route: "/scoreboard"),
            const DrawerTile(
                text: "Trocar Grupo", icon: Icons.sync_alt_rounded, route: "/"),
          ],
        ),
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile(
      {super.key,
      required this.text,
      required this.icon,
      required this.route,
      this.arguments});

  final String text;
  final IconData icon;
  final String route;
  final Object? arguments;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(10),
      leading: Icon(icon),
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
      onTap: () {
        Navigator.pushReplacementNamed(context, route, arguments: arguments);
      },
    );
  }
}
