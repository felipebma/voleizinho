import 'package:voleizinho/screens/group/group_creation_screen.dart';
import 'package:voleizinho/screens/group_home_screen.dart';
import 'package:voleizinho/screens/home/home_screen.dart';
import 'package:voleizinho/screens/players/players_screen.dart';
import 'package:voleizinho/screens/scoreboard_screen.dart';
import 'package:voleizinho/screens/settings_screen.dart';
import 'package:voleizinho/screens/team_creation_screen.dart';
import 'package:voleizinho/screens/teams_view_screen.dart';

var routes = {
  "/": (context) => HomeScreen(),
  "/group_creation": (context) => const GroupCreationScreen(),
  "/main_group": (context) => const GroupHomeScreen(),
  "/players": (context) => const PlayersScreen(),
  "/team_creation": (context) => const TeamCreationScreen(),
  "/teams_view": (context) => const TeamsViewScreen(),
  "/settings": (context) => const SettingsScreen(),
  "/scoreboard": (context) => const ScoreBoardScreen(),
};
