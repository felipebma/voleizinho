import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voleizinho/bloc/players/players_bloc.dart';
import 'package:voleizinho/model/group.dart';
import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/object_box.dart';
import 'package:voleizinho/objectbox.g.dart';
import 'package:voleizinho/repositories/group_repository.dart';
import 'package:voleizinho/repositories/player_repository.dart';
import 'package:voleizinho/repositories/store_repository.dart';
import 'package:voleizinho/routes.dart';
import 'package:voleizinho/services/player_service.dart';
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
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlayersBloc(PlayerService()),
      child: MaterialApp(
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
        routes: routes,
        initialRoute: "/",
      ),
    );
  }
}
