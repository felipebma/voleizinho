import 'package:voleizinho/screens/group/group_creation/group_creation_screen.dart';
import 'package:voleizinho/screens/group/group_home/group_home_screen.dart';
import 'package:voleizinho/screens/home/home_screen.dart';
import 'package:voleizinho/screens/players/players_screen.dart';
import 'package:voleizinho/screens/scoreboard/scoreboard_screen.dart';
import 'package:voleizinho/screens/group/group_settings/settings_screen.dart';
import 'package:voleizinho/screens/teams/teams_creation/team_creation_screen.dart';
import 'package:voleizinho/screens/teams/teams_view/teams_view_screen.dart';

var routes = {
  "/": (context) => const HomeScreen(),
  "/group_creation": (context) => const GroupCreationScreen(),
  "/main_group": (context) => const GroupHomeScreen(),
  "/players": (context) => const PlayersScreen(),
  "/team_creation": (context) => const TeamCreationScreen(),
  "/teams_view": (context) => const TeamsViewScreen(),
  "/settings": (context) => const GroupSettingsScreen(),
  "/scoreboard": (context) => const ScoreBoardScreen(),
};
