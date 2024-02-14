import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:voleizinho/bloc/group/groups_bloc.dart';
import 'package:voleizinho/bloc/player/players_bloc.dart';
import 'package:voleizinho/bloc/team/teams_bloc.dart';
import 'package:voleizinho/model/player.dart';
import 'package:voleizinho/object_box.dart';
import 'package:voleizinho/objectbox.g.dart';
import 'package:voleizinho/repositories/group_repository.dart';
import 'package:voleizinho/repositories/player_repository.dart';
import 'package:voleizinho/repositories/store_repository.dart';
import 'package:voleizinho/routes.dart';
import 'package:voleizinho/services/players/player_service.dart';
import 'package:voleizinho/services/user_preferences/user_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserPreferences.initUserPreferences();

  GetIt getIt = GetIt.I;

  StoreRepository storeRepository = StoreRepository();
  await storeRepository.initStore();
  ObjectBox objectBox = await ObjectBox.create();
  getIt.registerSingleton<ObjectBox>(objectBox);

  getIt.registerSingleton<GroupRepository>(GroupRepository());
  Box<Player> playerBox = objectBox.store.box<Player>();
  PlayerRepository.init(playerBox);
  getIt.registerSingleton<PlayerService>(PlayerService(PlayerRepository()));
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<PlayersBloc>(create: (context) => PlayersBloc()),
        BlocProvider<GroupsBloc>(create: (context) => GroupsBloc()),
        BlocProvider<TeamsBloc>(create: (context) => TeamsBloc()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
      routes: routes,
      initialRoute: "/",
    );
  }
}
