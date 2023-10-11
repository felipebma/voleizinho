import 'package:flutter/material.dart';

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
              const DrawerHeader(
                child: Text(
                  '',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
              ),
            const DrawerTile(
                text: "Menu Principal", icon: Icons.menu, route: "/"),
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
          ],
        ),
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile(
      {super.key, required this.text, required this.icon, required this.route});

  final String text;
  final IconData icon;
  final String route;

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
        Navigator.pushReplacementNamed(context, route);
      },
    );
  }
}
