import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voleizinho/model/group.dart';
import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/object_box.dart';
import 'package:voleizinho/objectbox.g.dart';
import 'package:voleizinho/playersDB.dart';
import 'package:voleizinho/repositories/group_repository.dart';
import 'package:voleizinho/repositories/player_repository.dart';
import 'package:voleizinho/repositories/store_repository.dart';
import 'package:voleizinho/screens/group_home_screen.dart';
import 'package:voleizinho/screens/home_screen.dart';
import 'package:voleizinho/screens/players_screen.dart';
import 'package:voleizinho/screens/scoreboard_screen.dart';
import 'package:voleizinho/screens/settings_screen.dart';
import 'package:voleizinho/screens/team_creation_screen.dart';
import 'package:voleizinho/screens/teams_view_screen.dart';
import 'package:voleizinho/services/team_match_service.dart';
import 'package:voleizinho/services/user_preferences.dart';

late ObjectBox objectBox;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserPreferences.initUserPreferences();

  StoreRepository storeRepository = StoreRepository();
  await storeRepository.initStore();
  await TeamMatchService.loadStoredTeams();
  objectBox = await ObjectBox.create();
  Box<Player> playerBox = objectBox.store.box<Player>();
  Box<Group> groupBox = objectBox.store.box<Group>();
  GroupRepository.init(groupBox);
  PlayerRepository.init(playerBox);
  if (PlayerRepository().getPlayers().isEmpty) {
    for (Player p in playersDB) {
      PlayerRepository().addPlayer(p);
    }
  }
  groupBox.removeAll();
  groupBox.put(
    Group.withArgs(
      name: "Default",
    ),
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MainApp(storeRepository: storeRepository));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.storeRepository});

  final StoreRepository storeRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFCDE8DE),
        primaryTextTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            fontFamily: "poller_one",
          ),
        ),
      ),
      routes: {
        "/main_group": (context) => const GroupHomeScreen(),
        "/": (context) => HomeScreen(),
        "/players": (context) => const PlayersScreen(),
        "/team_creation": (context) => const TeamCreationScreen(),
        "/teams_view": (context) => const TeamsViewScreen(),
        "/settings": (context) => const SettingsScreen(),
        "/scoreboard": (context) => const ScoreBoardScreen(),
      },
      initialRoute: "/",
    );
  }
}
